require 'spec_helper'

describe Notice do
  let(:notice) { Fabricate.build(:notice) }

  context "validation" do
    it "is valid" do
      expect(notice).to be_valid
    end
  end

  context "defaults" do
    it "is valid" do
      notice = Fabricate(:notice)
      expect(notice).to be_open
      expect(notice.token).to be_present
    end
  end

  context "burning" do
    it "burns a notice" do
      notice = Fabricate(:notice)

      expect { notice.burn! }.to change { notice.reload.status }.from("open").to("closed")
      expect(notice.data).to eql({})
    end

    it "handles unauthorized openings" do
      notice = Fabricate.build(:notice, openings: [Fabricate.build(:opening)])
      notice.apply_policy(authorized: false)
      expect(notice.status).to eql("open")

      notice.openings << Fabricate.build(:opening)
      notice.openings << Fabricate.build(:opening)
      expect { notice.apply_policy(authorized: false) }.to change { notice.status }.from("open").to("disabled")
    end

    it "handles burn_after_reading" do
      notice = Fabricate.build(:notice)
      expect { notice.apply_policy(authorized: true) }.to change { notice.status }.from("open").to("closed")
    end

    it "handles burn_after_openings" do
      notice = Fabricate(:notice, policy: Fabricate(:policy_openings))
      notice.apply_policy(authorized: true)
      expect(notice.status).to eql("open")

      notice.openings << Fabricate(:authorized_opening)
      notice.openings << Fabricate(:authorized_opening)

      notice.apply_policy(authorized: true)
      expect(notice.status).to eql("open")

      notice.openings << Fabricate(:authorized_opening)
      expect { notice.apply_policy(authorized: true) }.to change { notice.status }.from("open").to("closed")
    end

    it "handles burn_after_time" do
      notice = Fabricate(:notice, policy: Fabricate(:policy_time))
      notice.apply_policy(authorized: true)
      expect(notice.status).to eql("open")

      travel_to(1.week.from_now) do
        expect { notice.apply_policy(authorized: true) }.to change { notice.status }.from("open").to("closed")
      end
    end
  end

  context "encryption" do
    it "stores and reads data encryped" do
      notice.write_data('moin', 'SoSecret666')
      expect(notice.read_data('SoSecret666')).to eql('moin')
      notice.save
      expect(notice.reload.read_data('SoSecret666')).to eql('moin')
    end

    it "checks if a secret is valid" do
      expect(notice.valid_secret?('some-secret')).to be_true
      expect(notice.valid_secret?('invalid')).to be_false
    end
  end

  context "scheduling" do
    it "finds expired burn_after_time notices" do
      notice = Fabricate(:notice, policy: Fabricate(:policy_time))
      expect(Notice.expired).to have(0).elements

      notice.update updated_at: 2.days.ago
      expect(Notice.expired).to have(1).elements
    end

    it "burns expired notices" do
      notice = Fabricate(:notice, policy: Fabricate(:policy_time), updated_at: 2.days.ago)

      expect{ Notice.burn_expired }.to_not change { notice.reload }

      travel_to 10.days.from_now do
        expect{
          Notice.burn_expired
        }.to change { notice.reload.status }.from('open').to('closed')
      end
    end
  end
end

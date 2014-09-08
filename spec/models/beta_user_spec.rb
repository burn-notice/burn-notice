require 'spec_helper'

describe BetaUser do

  context "validation" do
    let(:beta_user) { Fabricate.build(:beta_user) }

    it "is valid" do
      expect(beta_user).to be_valid
    end
  end

  context "mailing" do
    it "sends invitation to users" do
      2.times { Fabricate(:beta_user) }

      expect { BetaUser.send_invite }.to change { ActionMailer::Base.deliveries.size }.by(0)

      travel_to 25.hours.from_now do
        expect { BetaUser.send_invite }.to change { ActionMailer::Base.deliveries.size }.by(2)
        expect { BetaUser.send_invite }.to change { ActionMailer::Base.deliveries.size }.by(0)
      end
    end
  end
end

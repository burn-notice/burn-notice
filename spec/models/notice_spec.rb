require 'spec_helper'

describe Notice do
  let(:notice) { Fabricate.build(:notice) }

  context "validation" do
    it "is valid" do
      expect(notice).to be_valid
    end
  end

  context "encryption" do
    it "stores and reads data encryped" do
      notice.write_data('moin', 'some-password')
      expect(notice.read_data('some-password')).to eql('moin')
      notice.save
      expect(notice.reload.read_data('some-password')).to eql('moin')
    end

    it "checks if a secret is valid" do
      expect(notice.valid_secret?('some-secret')).to be_true
      expect(notice.valid_secret?('invalid')).to be_false
    end
  end

  context "policy" do
    it "has a default policy" do
      notice = Notice.new
      expect(notice.policy.name).to eql('burn_after_reading')
    end
  end
end

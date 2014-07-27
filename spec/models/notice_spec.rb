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
      expect(notice).to be_draft
      expect(notice.token).to be_present
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
end

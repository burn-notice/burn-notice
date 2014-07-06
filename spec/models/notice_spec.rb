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
      notice.write_data 'moin', Crypto::TEST_PASSWORD
      notice.save

      expect(notice.reload.read_data(Crypto::TEST_PASSWORD)).to eql('moin')
    end
  end
end

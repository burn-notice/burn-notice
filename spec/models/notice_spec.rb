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
      notice.update_attributes! data: 'moin'

      expect(notice[:data]).to have(3).keys
      expect(notice.reload.data).to eql('moin')
    end
  end
end

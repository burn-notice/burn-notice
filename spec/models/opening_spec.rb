require 'spec_helper'

describe Opening do
  let(:opening) { Fabricate.build(:opening) }

  context "validation" do
    it "is valid" do
      expect(opening).to be_valid
    end
  end
end

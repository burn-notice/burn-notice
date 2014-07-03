require 'spec_helper'

describe Policy do

  let(:policy) { Fabricate.build(:policy) }

  context "validation" do
    it "is valid" do
      expect(policy).to be_valid
    end
  end
end

require 'spec_helper'

describe Policy do
  let(:policy) { Fabricate.build(:policy) }

  context "validation" do
    it "is valid" do
      expect(policy).to be_valid
    end
  end

  context "creation" do
    it "creates a policy from name" do
      policy = Policy.from_name
      expect(policy).to be_valid

      policy = Policy.from_name(name: 'burn_after_time', duration: 5)
      expect(policy).to be_valid
      expect(policy.setting).to eql({"duration"=>5})

      policy = Policy.from_name(name: 'burn_after_openings', amount: 7)
      expect(policy).to be_valid
      expect(policy.setting).to eql({"amount"=>7})
    end
  end
end

require 'spec_helper'

describe Policy do
  let(:policy) { Fabricate.build(:policy) }

  context "validation" do
    it "is valid" do
      expect(policy).to be_valid
    end
  end

  context "creation" do
    it "creates a policy from type" do
      policy = Policy.from_type('burn_after_reading')
      expect(policy).to be_valid

      policy = Policy.from_type('burn_after_time', duration: 5.minutes)
      expect(policy).to be_valid
      expect(policy.setting).to eql({"duration"=>300})

      policy = Policy.from_type('burn_after_openings', count: 7)
      expect(policy).to be_valid
      expect(policy.setting).to eql({"count"=>7})
    end
  end
end

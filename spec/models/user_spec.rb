require 'spec_helper'

describe User do
  context "validation" do
    it "is valid" do
      user = Fabricate.build(:user)
      expect(user).to be_valid
    end
  end
end

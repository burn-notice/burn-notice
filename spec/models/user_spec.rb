require 'spec_helper'

describe User do
  let(:user) { Fabricate.build(:user) }

  context "validation" do
    it "is valid" do
      expect(user).to be_valid
    end
  end
end

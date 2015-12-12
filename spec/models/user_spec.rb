require 'spec_helper'

describe User do
  let(:user) { Fabricate.build(:user) }
  let(:admin) { Fabricate.build(:admin) }

  context "validation" do
    it "is valid" do
      expect(user).to be_valid
    end
  end

  context "admin" do
    it "has the proper role" do
      expect(admin).to be_admin
    end
  end
end

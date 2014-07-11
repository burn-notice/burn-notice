require 'spec_helper'

describe User do
  context "validation" do
    it "is valid" do
      user = Fabricate.build(:user)
      expect(user).to be_valid
    end
  end

  context "authorization" do
    it "creates new users when they are unkown" do
      expect { User.handle_authorization(GITHUB_AUTH_HASH) }.to change { User.count + Authorization.count }.by(2)
    end
  end
end

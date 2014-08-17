require 'spec_helper'

describe User do
  let(:user) { Fabricate.build(:user) }

  context "validation" do
    it "is valid" do
      expect(user).to be_valid
    end
  end

  # context "authorization" do
  #   it "creates new users when they are unkown" do
  #     expect { User.handle_authorization(GITHUB_AUTH_HASH) }.to change { User.count + Authorization.count }.by(2)
  #   end
  # end
end

require 'spec_helper'

describe UsersHelper do
  let(:user) { Fabricate.build(:user, nickname: 'lora', email: 'lora@burn-notice.me') }

  context "gravatar" do
    it "can calculate proper gravatar hashes" do
      expect(helper.gravatar(user)).to eql("<img alt=\"lora\" title=\"lora\" src=\"//www.gravatar.com/avatar/2b2add070f207cf95bbd160dd13224ae\" />")
    end
  end
end

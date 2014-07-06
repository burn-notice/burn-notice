require "spec_helper"

describe UserMailer do
  describe "new_user" do
    let(:user) { Fabricate.build(:user) }
    let(:mail) { UserMailer.signup(user) }

    it "renders the headers" do
      mail.subject.should_not be_nil
      mail.to.should eq([user.email])
    end

    it "renders the body" do
      mail.body.encoded.should match("validate")
    end
  end

end

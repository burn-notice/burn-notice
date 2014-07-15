require "spec_helper"

describe UserMailer do

  describe "signup" do
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

  describe "beta" do
    let(:beta_user) { Fabricate.build(:beta_user) }
    let(:mail) { UserMailer.beta(beta_user) }

    it "renders the headers" do
      mail.subject.should_not be_nil
      mail.to.should eq([beta_user.email])
    end

    it "renders the body" do
      mail.body.encoded.should match("private Beta")
    end
  end
end

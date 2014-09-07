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

  describe "notify" do
    let(:user) { Fabricate.build(:user) }
    let(:mail) { UserMailer.notify(user) }

    it "renders the headers" do
      mail.subject.should_not be_nil
      mail.to.should eq([user.email])
    end

    it "renders the body" do
      mail.body.encoded.should match("new Burn-Notice")
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
      mail.body.encoded.should match("private βeta")
    end
  end

  describe "invite" do
    let(:beta_user) { Fabricate.build(:beta_user) }
    let(:mail) { UserMailer.invite(beta_user) }

    it "renders the headers" do
      mail.subject.should_not be_nil
      mail.to.should eq([beta_user.email])
    end

    it "renders the body" do
      mail.body.encoded.should match("login through one of the following links")
    end
  end
end

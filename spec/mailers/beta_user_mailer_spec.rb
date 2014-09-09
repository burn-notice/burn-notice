require "spec_helper"

describe BetaUserMailer do
  let(:beta_user) { Fabricate(:beta_user) }

  describe "beta" do
    let(:mail) { BetaUserMailer.beta(beta_user) }

    it "renders the headers" do
      mail.subject.should_not be_nil
      mail.to.should eq([beta_user.email])
    end

    it "renders the body" do
      mail.body.encoded.should match("private βeta")
    end
  end

  describe "invite" do
    let(:mail) { BetaUserMailer.invite(beta_user) }

    it "renders the headers" do
      mail.subject.should_not be_nil
      mail.to.should eq([beta_user.email])
    end

    it "renders the body" do
      mail.body.encoded.should match("click the link below")
    end
  end
end

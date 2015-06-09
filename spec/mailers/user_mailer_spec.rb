require "spec_helper"

describe UserMailer do
  before do
    I18n.locale = :en
  end

  describe "signup" do
    let(:user) { Fabricate(:user) }
    let(:mail) { UserMailer.signup(user) }

    it "renders the mail" do
      expect(mail.subject).to_not be_nil
      expect(mail.to).to eq([user.email])
      expect(mail.body.encoded).to match("validate")
    end
  end

  describe "notify" do
    let(:user)    { Fabricate(:user) }
    let(:notice)  { Fabricate(:notice) }
    let(:mail)    { UserMailer.notify(user, 'uschi@muschi.de', notice) }

    it "renders the headers" do
      expect(mail.subject).to_not be_nil
      expect(mail.to).to eq(['uschi@muschi.de'])
    end

    it "renders the body" do
      expect(mail.body.encoded).to match("new Burn-Notice")
    end
  end
end

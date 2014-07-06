require "spec_helper"

describe UserMailer do
  describe "new_user" do
    let(:mail) { UserMailer.new_user }

    it "renders the headers" do
      mail.subject.should eq("New user")
      mail.to.should eq(["to@example.org"])
      mail.from.should eq(["from@example.com"])
    end

    it "renders the body" do
      mail.body.encoded.should match("Hi")
    end
  end

end

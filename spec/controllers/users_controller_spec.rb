require 'spec_helper'

describe UsersController do
  before do
    @user = login
  end

  context "GET :show" do
    it "renders the users profile page" do
      get :show, id: @user

      expect(response).to be_success
    end

    it "redirects when it's the wrong user" do
      get :show, id: Fabricate(:user)

      expect(response).to be_redirect
    end
  end

  context "POST :update" do
    it "resets validation and sends an email when address is changed" do
      @user.update! validation_date: Time.now
      expect {
        post :update, id: @user, user: {email: 'different@email.com'}
      }.to change { @user.reload.validation_date }.from(@user.validation_date).to(nil)

      expect(response).to be_redirect
    end

    it "updates the nickname" do
      expect {
        post :update, id: @user, user: {nickname: 'new'}
      }.to change { @user.reload.nickname }.from(@user.nickname).to('new')

      expect(response).to be_redirect
    end
  end
end

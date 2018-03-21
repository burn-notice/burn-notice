require 'spec_helper'

describe PublicController do
  before do
    @notice = Fabricate(:notice_with_opening)
  end

  context "GET :open" do
    it "shows the notice form and registers an opening" do
      expect {
        get :open, params: {token: @notice.token}
      }.to change { @notice.openings.count }.by(1)

      expect(response).to be_successful
      expect(assigns[:notice]).to eql(@notice)
    end
  end

  context "POST :read" do
    it "redirects to root if notices is not open any longer" do
      @notice.burn!
      post :read, params: {token: @notice.token}

      expect(response).to redirect_to(root_path)
      expect(flash[:alert]).to_not be_empty
    end

    it "shows the secret message for valid secret" do
      expect {
        post :read, params: {token: @notice.token, opening_id: @notice.openings.last.id, answer: 'some-secret'}
      }.to change { @notice.reload.status }.from("unread").to("closed")

      expect(response).to be_successful
      expect(assigns[:notice]).to eql(@notice)
    end
  end
end

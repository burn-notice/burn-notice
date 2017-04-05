require 'spec_helper'

describe NoticesController do
  let(:user) { Fabricate(:user) }

  context "time-zone" do
    render_views

    let(:tz_user) { Fabricate(:user, time_zone: 'Hawaii') }

    before do
      travel_to(Time.utc(2015, 11, 11, 11, 11, 0)) do
        @notice = Fabricate(:notice, user: tz_user)
      end

      login(tz_user)
    end

    it "should switch to user-tz" do
      get :show, params: {id: @notice}
      expect(response.body).to include('11.11. 01:11')
    end
  end

  context "create" do
    before do
      login(user)
    end

    let(:notice_params) { { question: 'who?', answer: 'me!', content: 'that.' } }
    let(:policy_params) { { name: 'burn_after_reading' } }

    it "creates a notice" do
      expect {
        post :create, params: { notice: notice_params.merge(policy_attributes: policy_params) }
      }.to change(Notice, :count).by(1)

      expect(response).to be_a_redirect
    end
  end

  context "destroy" do
    before do
      @notice = Fabricate(:notice, user: user)

      login(user)
    end

    it "should remove data and mark as deleted" do
      expect {
        expect {
          post :destroy, params: {id: @notice}
          @notice.reload
        }.to change { @notice.status }.from('open').to('deleted')
      }.to change { @notice.data.empty? }.from(false).to(true)
    end
  end
end

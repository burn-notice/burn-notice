require 'spec_helper'

describe NoticesController do
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
      get :show, id: @notice
      expect(response.body).to include('11.11. 01:11')
    end
  end
end

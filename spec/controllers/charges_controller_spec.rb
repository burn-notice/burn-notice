require 'rails_helper'

describe ChargesController do
  before do
    @user = login
  end

  context "charges#index" do
    it "shows the pricing page" do
      get :index

      expect(response).to be_success
    end
  end
end

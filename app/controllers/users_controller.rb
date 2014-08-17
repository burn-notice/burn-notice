class UsersController < ApplicationController
  before_action :authenticate_current_user!

  def show
  end

  def update
  end

  private

  def user
    @user ||= User.find(params[:id])
  end
end

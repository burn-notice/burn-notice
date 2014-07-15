class BetaUsersController < ApplicationController
  layout 'beta'

  def index
    @beta_user = BetaUser.new
  end

  def create
    @beta_user = BetaUser.new(beta_user_params)
    if @beta_user.save
      redirect_to thank_you_beta_user_path(@beta_user)
    else
      flash.now[:alert] = "Ugh, something went wrong, please check your input!"
      render :index
    end
  end

  def thank_you
    @beta_user = BetaUser.find(params[:id])
  end

  private

  def beta_user_params
    params.require(:beta_user).permit(:email)
  end
end

class BetaUsersController < ApplicationController
  layout 'beta'

  def index
    @beta_user = BetaUser.new
  end

  def create
    @beta_user = BetaUser.new(beta_user_params)
    if @beta_user.save
      mail = UserMailer.beta(@beta_user)
      MailerJob.new.async.deliver(mail)
      redirect_to thank_you_beta_user_path(@beta_user)
    else
      flash.now[:alert] = "Ugh, something went wrong: #{@beta_user.errors.full_messages.to_sentence}"
      render :index
    end
  end

  def thank_you
    @beta_user = BetaUser.from_param(params[:id])
  end

  def invite
    @beta_user = BetaUser.from_param(params[:id])
    session[:beta_user_email] = @beta_user.email
  end

  private

  def beta_user_params
    params.require(:beta_user).permit(:email)
  end
end

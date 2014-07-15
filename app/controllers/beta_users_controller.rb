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
      session[:beta_user_id] = @beta_user.id
      redirect_to thank_you_beta_users_path
    else
      flash.now[:alert] = "Ugh, something went wrong: #{@beta_user.errors.full_messages.to_sentence}"
      render :index
    end
  end

  def thank_you
    @beta_user = BetaUser.find(session[:beta_user_id])
  end

  private

  def beta_user_params
    params.require(:beta_user).permit(:email)
  end
end

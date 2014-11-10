class UsersController < ApplicationController
  before_action :authenticate_current_user!

  def show
  end

  def update
    user.attributes = user_params
    if user.email_changed?
      user.validation_date = nil
      send_validation(current_user)
      flash[:notice] = t('users.profile_updated_and_confirmation_email')
    else
      flash[:notice] = t('users.profile_updated')
    end
    user.save!

    redirect_to user_path(current_user)
  end

  def confirmation_mail
    send_validation(current_user)

    redirect_to current_user, notice: t('users.confirmation_mail', email: current_user.email)
  end

  private

  def user_params
    params.require(:user).permit(:email, :nickname)
  end

  def user
    @user ||= User.find(params[:id])
  end

  def send_validation(user)
    mail = UserMailer.validate(user)
    MailerJob.new.async.deliver(mail)
  end
end

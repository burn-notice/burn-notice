class UsersController < ApplicationController
  before_action :authenticate!

  def show
  end

  def update
    current_user.attributes = user_params
    if current_user.email_changed?
      current_user.validation_date = nil
      if current_user.save
        send_validation(current_user)
        flash[:notice] = t('users.profile_updated_and_confirmation_email')
        redirect_to user_path(current_user), notice: t('users.profile_updated')
      else
        redirect_to user_path(current_user), alert: current_user.errors.full_messages.to_sentence
      end
    else
      current_user.save!
      redirect_to user_path(current_user), notice: t('users.profile_updated')
    end
  end

  def confirmation_mail
    send_validation(current_user)

    redirect_to current_user, notice: t('users.confirmation_mail', email: current_user.email)
  end

  def destroy
    current_user.destroy!
    sign_out

    redirect_to root_path, notice: t('users.destroyed')
  end

  private

  def user_params
    params.require(:user).permit(:email, :nickname, :time_zone, :disable_burned_emails)
  end

  def send_validation(user)
    mail = UserMailer.validate(user)
    MailerJob.perform_async(mail, I18n.locale)
  end
end

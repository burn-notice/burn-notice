class UsersController < ApplicationController
  before_action :authenticate_current_user!

  def show
  end

  def update
  end

  def confirmation_mail
    mail = UserMailer.signup(current_user)
    MailerJob.new.async.deliver(mail)
    redirect_to current_user, notice: "A confirmation e-mail was sent to #{current_user.email}!"
  end

  private

  def user
    @user ||= User.find(params[:id])
  end
end

class UsersController < ApplicationController
  before_action :authenticate_current_user!

  def mailing
    mail = UserMailer.signup(user)
    MailerJob.new.async.deliver(mail)

    render text: 'ok'
  end

  private

  def user
    @user ||= User.find(params[:id])
  end
end

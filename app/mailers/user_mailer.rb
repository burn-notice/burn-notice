class UserMailer < ActionMailer::Base
  default from: "peter@burn-notice.me", bcc: "peter@burn-notice.me"

  def signup(user)
    @user = user

    mail to: @user.email, subject: 'You are signed-up, please validate your e-mail address!'
  end

  def validate(user)
    @user = user

    mail to: @user.email, subject: 'Please validate your e-mail address!'
  end

  def notify(user, email, notice)
    @user = user
    @notice = notice

    mail to: email, subject: "You've got a new Burn-Notice!", reply_to: user.email
  end

  def email_auth(email, token)
    @token = token

    mail to: email, subject: 'Login to Burn-Notice'
  end
end

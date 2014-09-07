class UserMailer < ActionMailer::Base
  default from: "peter@burn-notice.me", bcc: "peter@burn-notice.me"

  def signup(user)
    @user = user

    mail to: @user.email, subject: 'Validate your e-mail!'
  end

  def beta(beta_user)
    @beta_user = beta_user

    mail to: @beta_user.email, subject: 'Welcome to our private ßeta!'
  end

  def invite(beta_user)
    @beta_user = beta_user

    mail to: @beta_user.email, subject: 'Try the private ßeta now!'
  end

  def notify(user, email, notice)
    @user = user
    @notice = notice

    mail to: email, subject: "You've got a new Burn-Notice!", reply_to: user.email
  end
end

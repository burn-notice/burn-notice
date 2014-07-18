class UserMailer < ActionMailer::Base
  default from: "peter@burn-notice.me"

  def signup(user)
    @user = user

    mail to: @user.email, subject: 'Validate your e-mail!'
  end

  def beta(beta_user)
    @beta_user = beta_user

    mail to: @beta_user.email, subject: 'Welcome to our private ßeta!'
  end
end

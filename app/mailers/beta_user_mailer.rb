class BetaUserMailer < ActionMailer::Base
  default from: "peter@burn-notice.me", bcc: "peter@burn-notice.me"

  def beta(beta_user)
    @beta_user = beta_user

    mail to: @beta_user.email, subject: 'Welcome to our private ßeta!'
  end

  def invite(beta_user)
    @beta_user = beta_user

    mail to: @beta_user.email, subject: 'Try the private ßeta now!'
  end
end

class UserMailer < ActionMailer::Base
  default from: "peter@burn-notice.me", bcc: "peter@burn-notice.me"

  def signup(user)
    @user = user

    mail to: @user.email, subject: t('mailers.signup')
  end

  def validate(user)
    @user = user

    mail to: @user.email, subject: t('mailers.validate')
  end

  def notify(user, email, notice)
    @user = user
    @notice = notice

    mail to: email, subject: t('mailers.notify'), reply_to: user.email
  end

  def burned(notice)
    @notice = notice
    @user = notice.user

    mail to: @user.email, subject: t('mailers.burned')
  end

  def email_auth(email, token)
    @token = token

    mail to: email, subject: t('mailers.email_auth')
  end
end

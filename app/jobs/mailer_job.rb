class MailerJob
  include SuckerPunch::Job

  def perform(mail, locale)
    I18n.locale = locale
    mail.deliver_now!
  end
end

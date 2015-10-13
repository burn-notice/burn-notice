class MailerJob
  include SuckerPunch::Job

  def deliver(mail, locale)
    I18n.locale = locale
    mail.deliver_now!
  end
end

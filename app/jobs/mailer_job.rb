class MailerJob
  if Rails.env.test?
    def self.perform_async(*args)
      new.perform(*args)
    end
  else
    include SuckerPunch::Job
  end

  def perform(mail, locale)
    I18n.locale = locale
    mail.deliver_now!
  end
end

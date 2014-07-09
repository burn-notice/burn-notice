class MailerJob
  include SuckerPunch::Job

  def deliver(mail)
    mail.deliver!
  end
end

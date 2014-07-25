require 'exception_notification/rails'

ExceptionNotification.configure do |config|
  config.ignore_if do |exception, options|
    not Rails.env.production?
  end

  options = {
    email_prefix:         "[ERROR] ",
    sender_address:       "errors@burn-notice.me",
    exception_recipients: "peter@burn-notice.me",
  }
  config.add_notifier(:email, options)
end

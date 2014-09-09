# Preview all emails at http://localhost:3000/rails/mailers/
class UserMailerPreview < ActionMailer::Preview
  def signup
    user = User.first
    UserMailer.signup(user)
  end

  def validate
    user = User.first
    UserMailer.validate(user)
  end

  def notify
    user = User.first
    notice = Notice.first
    UserMailer.notify(user, 'recipient@mail.de', notice)
  end
end

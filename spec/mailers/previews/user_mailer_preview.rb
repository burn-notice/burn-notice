# Preview all emails at http://localhost:3000/rails/mailers/
class UserMailerPreview < ActionMailer::Preview
  def signup
    user = User.first
    UserMailer.signup(user)
  end
end

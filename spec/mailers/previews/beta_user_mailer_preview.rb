# Preview all emails at http://localhost:3000/rails/mailers/
class BetaUserMailerPreview < ActionMailer::Preview
  def beta
    beta_user = BetaUser.first
    BetaUserMailer.beta(beta_user)
  end

  def invite
    beta_user = BetaUser.first
    BetaUserMailer.invite(beta_user)
  end
end

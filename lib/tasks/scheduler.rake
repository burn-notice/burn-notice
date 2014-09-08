desc "send email to beta-users automatically"
task send_beta_invite: :environment do
  BetaUser.send_invite
end

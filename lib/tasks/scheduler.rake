desc "delete expired burn-notices"
task burn_expired: :environment do
  Notice.burn_expired
end

Fabricator(:google_auth_connection) do
  status { 'pending' }
  email  { Faker::Internet.email }
  token  { SecureRandom.hex(16) }
  sender
end

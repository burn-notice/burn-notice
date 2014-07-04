Fabricator(:user) do
  nickname  { Faker::Internet.user_name(3..30) }
  email     { Faker::Internet.email }
  token     { SecureRandom.hex(16) }
end

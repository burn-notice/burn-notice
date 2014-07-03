Fabricator(:notice) do
  data { Faker::Lorem.paragraph }
  user
  policy
end

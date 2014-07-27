Fabricator(:article) do
  title { Faker::Lorem.sentence }
  body  { Faker::Lorem.paragraph }
  tags  { Faker::Lorem.words }
  published_at { Time.now }
  user
  policy
end

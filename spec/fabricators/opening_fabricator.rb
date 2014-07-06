Fabricator(:opening) do
  notice
  ip { Faker::Internet.ip_v4_address }
  meta { {} }
end

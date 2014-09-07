Fabricator(:opening) do
  notice
  ip { Faker::Internet.ip_v4_address }
  meta { {} }
end

Fabricator(:authorized_opening, from: :opening) do
  authorization { :authorized }
end

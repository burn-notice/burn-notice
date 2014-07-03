Fabricator(:policy) do
  name { Faker::Lorem.characters(20) }
  setting { {'some' => 'setting'} }
end

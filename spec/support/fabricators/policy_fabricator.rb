Fabricator(:policy) do
  name { 'burn_after_reading' }
end

Fabricator(:policy_time, from: :policy) do
  name { 'burn_after_time' }
  setting { {'duration' => 5} }
end

Fabricator(:policy_openings, from: :policy) do
  name { 'burn_after_openings' }
  setting { {'amount' => 3} }
end

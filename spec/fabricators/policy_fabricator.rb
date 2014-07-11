Fabricator(:policy) do
  name { 'burn_after_time' }
  setting { {'duration' => 7.days} }
end

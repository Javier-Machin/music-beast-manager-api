def generate_artist_hash
  { name: Faker::Name.name }
end

FactoryBot.define do
  factory :track do
    title { Faker::Lorem.word }
    artist { generate_artist_hash }
  end
end
def generate_artist_hash
  { name: Faker::Name.name }
end

FactoryBot.define do
  factory :track do
    title { Faker::Lorem.word }
    artist { generate_artist_hash }
    before(:create) do |track|
      track.created_by = create(:user).id
    end
  end
end
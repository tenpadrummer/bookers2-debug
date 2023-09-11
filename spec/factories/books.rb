FactoryBot.define do
  factory :book do
    title { Faker::Lorem.characters(number: 5) }
    body { Faker::Lorem.characters(number: 20) }
    category { Faker::Lorem.characters(number: 4) }
    user
  end
end

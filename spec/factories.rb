FactoryBot.define do
  factory :joke do
    category { Faker::Lorem.word }
    content { Faker::Lorem.paragraph }
  end
end
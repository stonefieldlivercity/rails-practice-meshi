FactoryBot.define do
  factory :user do
    name { Faker::Lorem.characters(number: 6) }
    email { Faker::Internet.email }
    password { 'password' }
    password_confirmation { 'password' }
  end
end
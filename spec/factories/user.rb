FactoryBot.define do
  factory :user do
    name { "Test User" }
    email { Faker::Internet.email }
    password_digest { "password" }
    role { 0 }
  end
end

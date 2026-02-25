FactoryBot.define do
  factory :category do
    sequence(:name) { |n| "Scented-#{n}" }
  end
end

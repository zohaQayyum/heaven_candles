FactoryBot.define do
  factory :product do
    name { "Lavender Bliss" }
    description { "Relaxing lavender candle" }
    association :category
  end
end

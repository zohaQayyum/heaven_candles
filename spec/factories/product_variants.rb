FactoryBot.define do
  factory :product_variant do
    association :product
    size { :small }
    price { 1200.0 }
    stock { 10 }
    sequence(:sku) { |n| "HC-SKU-#{n}" }
  end
end

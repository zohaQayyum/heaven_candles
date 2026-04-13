FactoryBot.define do
  factory :order do
    association :user
    status { :pending }
    total_amount { 50.00 }
    shipping_name { "Test User" }
    shipping_address { "123 Test Street" }
    shipping_city { "Faisalabad" }
    shipping_phone { "+92 300 1234567" }
    sequence(:order_number) { |n| "HC-TEST#{n}" }
  end
end

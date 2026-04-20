FactoryBot.define do
  factory :coupon do
    code { "MyString" }
    discount_type { 1 }
    discount_value { "9.99" }
    expires_at { "2026-04-20 16:55:37" }
    active { false }
  end
end

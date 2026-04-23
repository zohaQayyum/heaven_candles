FactoryBot.define do
  factory :review do
    product { nil }
    user { nil }
    rating { 1 }
    comment { "MyText" }
    guest_name { "MyString" }
    guest_email { "MyString" }
    status { 1 }
  end
end

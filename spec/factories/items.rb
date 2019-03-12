FactoryBot.define do
  factory :item do
    name { "My Item" }
    description { "Item Description" }
    unit_price { 1.5 }
    merchant { nil }
    created_at { "2019-03-12 11:05:49" }
    updated_at { "2019-03-12 11:05:49" }
  end
end

FactoryBot.define do
  factory :invoice_item do
    quantity { 1 }
    unit_price { 1.5 }
    created_at { "2019-03-12 11:25:50" }
    updated_at { "2019-03-12 11:25:50" }
    item { nil }
    invoice { nil }
  end
end

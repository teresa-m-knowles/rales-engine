FactoryBot.define do
  factory :invoice_item do
    item
    invoice
    quantity { 1 }
    unit_price { item.unit_price }
    created_at { "2019-03-12 11:25:50" }
    updated_at { "2019-03-12 11:25:50" }
  end
end

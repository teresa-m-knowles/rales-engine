FactoryBot.define do
  factory :transaction do
    credit_card_number { "MyString" }
    result { 1 }
    created_at { "2019-03-12 11:34:05" }
    updated_at { "2019-03-12 11:34:05" }
    invoice { nil }
  end
end

FactoryBot.define do
  factory :invoice do
    status { 0 }
    created_at { "2019-03-12 11:12:43" }
    updated_at { "2019-03-12 11:12:43" }
    customer { nil }
    merchant { nil }
  end
end

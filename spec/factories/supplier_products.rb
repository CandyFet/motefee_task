FactoryBot.define do
  factory :supplier_product do
    supplier
    product
    count { Faker::Number.between(from: 1, to: 10) }
    delivery_time { '{ \"eu\": 1, \"us\": 6, \"uk\": 2 }' }
  end
end

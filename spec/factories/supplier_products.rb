FactoryBot.define do
  factory :supplier_product do
    supplier
    product
    quantity { Faker::Number.between(from: 1, to: 10) }
    delivery_time { { eu: 1, uk: 2, us: 3 }.to_json }
  end
end

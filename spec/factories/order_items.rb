FactoryBot.define do
  factory :order_item do
    order
    product
    count { Faker::Number.between(from: 1, to: 10) }
  end
end

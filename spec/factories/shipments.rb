FactoryBot.define do
  factory :shipment do
    order
    supplier
    delivery_date { DateTime.now }
  end
end

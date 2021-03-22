class Supplier < ApplicationRecord
  has_many :supplier_products
  has_many :products, through: :supplier_products
  has_many :shipments

  validates :name, presence: true
end

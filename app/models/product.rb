class Product < ApplicationRecord
	has_many :supplier_products
  has_many :suppliers, through: :supplier_products
end

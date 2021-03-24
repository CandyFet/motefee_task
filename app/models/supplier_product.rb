class SupplierProduct < ApplicationRecord
  belongs_to :supplier
  belongs_to :product

  scope :by_supplier_id, ->(supplier_id) { where(supplier_id: supplier_id) if supplier_id.present? }
  scope :by_product_id, ->(product_id) { where(product_id: product_id) if product_id.present? }
end

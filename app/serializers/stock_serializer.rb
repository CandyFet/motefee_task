class StockSerializer < ActiveModel::Serializer
  attributes :id, :supplier_name, :product_name, :quantity, :delivery_time

  def supplier_name
    object.supplier.name
  end

  def product_name
    object.product.name
  end

  def delivery_time
    JSON.parse(object.delivery_time)
  end
end

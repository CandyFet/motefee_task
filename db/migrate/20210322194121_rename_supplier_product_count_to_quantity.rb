class RenameSupplierProductCountToQuantity < ActiveRecord::Migration[6.0]
  def change
    rename_column :supplier_products, :count, :quantity
  end
end

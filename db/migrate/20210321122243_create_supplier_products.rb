class CreateSupplierProducts < ActiveRecord::Migration[6.0]
  def change
    create_table :supplier_products do |t|
      t.references :supplier, null: false, foreign_key: true
      t.references :product, null: false, foreign_key: true
      t.integer :count, default: 0
      t.json :delivery_time

      t.timestamps
    end
  end
end

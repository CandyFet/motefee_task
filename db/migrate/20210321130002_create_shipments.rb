class CreateShipments < ActiveRecord::Migration[6.0]
  def change
    create_table :shipments do |t|
      t.references :order, null: false, foreign_key: true
      t.references :supplier, null: false, foreign_key: true
      t.datetime :delivery_date

      t.timestamps
    end
  end
end

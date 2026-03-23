class CreateLots < ActiveRecord::Migration[8.0]
  def change
    create_table :lots do |t|
      t.integer :product_id
      t.integer :location_id
      t.integer :supplier_id
      t.string :lot_number
      t.integer :quantity
      t.date :expiry_date
      t.date :received_date

      t.timestamps
    end
  end
end

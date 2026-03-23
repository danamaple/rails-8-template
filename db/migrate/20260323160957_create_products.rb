class CreateProducts < ActiveRecord::Migration[8.0]
  def change
    create_table :products do |t|
      t.string :sku
      t.string :name
      t.text :description
      t.string :frontend_name
      t.string :upc
      t.string :flavour
      t.string :size
      t.string :weight
      t.decimal :supply_price
      t.decimal :retail_price
      t.boolean :is_active
      t.boolean :new_arrival
      t.date :new_arrival_date
      t.string :image_url
      t.integer :inventory_level
      t.boolean :track_inventory
      t.integer :reorder_quantity
      t.integer :reorder_point
      t.integer :brand_id
      t.integer :supplier_id
      t.integer :product_category_one_id
      t.integer :product_category_two_id
      t.integer :product_category_three_id

      t.timestamps
    end
  end
end

class CreatePromotions < ActiveRecord::Migration[8.0]
  def change
    create_table :promotions do |t|
      t.string :name
      t.date :start_date
      t.date :end_date
      t.integer :buy_quantity
      t.integer :get_quantity
      t.decimal :discount_percent
      t.string :discount_type
      t.decimal :discount_value
      t.integer :min_quantity
      t.text :description

      t.timestamps
    end
  end
end

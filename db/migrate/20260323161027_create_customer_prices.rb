class CreateCustomerPrices < ActiveRecord::Migration[8.0]
  def change
    create_table :customer_prices do |t|
      t.integer :product_id
      t.integer :company_id
      t.integer :min_quantity
      t.integer :max_quantity
      t.decimal :unit_price

      t.timestamps
    end
  end
end

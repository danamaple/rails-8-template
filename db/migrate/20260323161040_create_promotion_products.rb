class CreatePromotionProducts < ActiveRecord::Migration[8.0]
  def change
    create_table :promotion_products do |t|
      t.integer :promotion_id
      t.integer :product_id

      t.timestamps
    end
  end
end

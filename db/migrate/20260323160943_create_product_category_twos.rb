class CreateProductCategoryTwos < ActiveRecord::Migration[8.0]
  def change
    create_table :product_category_twos do |t|
      t.string :name
      t.integer :product_category_one_id

      t.timestamps
    end
  end
end

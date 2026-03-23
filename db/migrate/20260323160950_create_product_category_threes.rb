class CreateProductCategoryThrees < ActiveRecord::Migration[8.0]
  def change
    create_table :product_category_threes do |t|
      t.string :name
      t.integer :product_category_two_id

      t.timestamps
    end
  end
end

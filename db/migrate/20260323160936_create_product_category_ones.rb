class CreateProductCategoryOnes < ActiveRecord::Migration[8.0]
  def change
    create_table :product_category_ones do |t|
      t.string :name

      t.timestamps
    end
  end
end

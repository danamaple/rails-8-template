class CreatePriceCategories < ActiveRecord::Migration[8.0]
  def change
    create_table :price_categories do |t|
      t.string :name

      t.timestamps
    end
  end
end

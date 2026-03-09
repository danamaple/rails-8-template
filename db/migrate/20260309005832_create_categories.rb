class CreateCategories < ActiveRecord::Migration[8.0]
  def change
    create_table :categories do |t|
      t.string :category
      t.integer :portfolios_count

      t.timestamps
    end
  end
end

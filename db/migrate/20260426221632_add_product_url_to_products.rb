class AddProductUrlToProducts < ActiveRecord::Migration[8.0]
  def change
    add_column :products, :product_url, :string
  end
end

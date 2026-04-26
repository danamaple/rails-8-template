class AddPriceCategoryToCompanies < ActiveRecord::Migration[8.0]
  def change
    add_column :companies, :price_category_id, :integer
  end
end

class CreatePortfolios < ActiveRecord::Migration[8.0]
  def change
    create_table :portfolios do |t|
      t.integer :company_id
      t.integer :category_id

      t.timestamps
    end
  end
end

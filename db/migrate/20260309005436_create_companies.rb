class CreateCompanies < ActiveRecord::Migration[8.0]
  def change
    create_table :companies do |t|
      t.string :company_name
      t.string :website
      t.string :status
      t.text :notes
      t.integer :portfolios_count

      t.timestamps
    end
  end
end

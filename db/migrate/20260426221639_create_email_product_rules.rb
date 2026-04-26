class CreateEmailProductRules < ActiveRecord::Migration[8.0]
  def change
    create_table :email_product_rules do |t|
      t.integer :email_template_id
      t.string :field
      t.string :measurement
      t.string :value

      t.timestamps
    end
  end
end

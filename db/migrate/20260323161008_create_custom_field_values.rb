class CreateCustomFieldValues < ActiveRecord::Migration[8.0]
  def change
    create_table :custom_field_values do |t|
      t.integer :product_id
      t.integer :custom_field_id
      t.string :value

      t.timestamps
    end
  end
end

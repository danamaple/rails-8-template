class CreateEmailTemplateProducts < ActiveRecord::Migration[8.0]
  def change
    create_table :email_template_products do |t|
      t.integer :email_template_id
      t.integer :product_id
      t.integer :position

      t.timestamps
    end
  end
end

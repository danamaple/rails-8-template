class CreateSuppliers < ActiveRecord::Migration[8.0]
  def change
    create_table :suppliers do |t|
      t.string :name
      t.string :contact_name
      t.string :email
      t.string :phone
      t.string :website

      t.timestamps
    end
  end
end

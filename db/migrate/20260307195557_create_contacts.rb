class CreateContacts < ActiveRecord::Migration[8.0]
  def change
    create_table :contacts do |t|
      t.integer :company_id
      t.string :first_name
      t.string :last_name
      t.string :preferred_name
      t.string :title
      t.string :email
      t.integer :phone
      t.string :linkedin
      t.text :notes
      t.boolean :general_company_contact

      t.timestamps
    end
  end
end

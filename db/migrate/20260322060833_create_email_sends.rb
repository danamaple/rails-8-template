class CreateEmailSends < ActiveRecord::Migration[8.0]
  def change
    create_table :email_sends do |t|
      t.integer :contact_id
      t.integer :email_template_id
      t.integer :user_id
      t.string :subject
      t.text :body
      t.string :status

      t.timestamps
    end
  end
end

class AddSmtpFieldsToUsers < ActiveRecord::Migration[8.0]
  def change
    add_column :users, :smtp_address, :string
    add_column :users, :smtp_port, :integer
    add_column :users, :smtp_username, :string
    add_column :users, :smtp_password, :string
    add_column :users, :smtp_from_email, :string
  end
end

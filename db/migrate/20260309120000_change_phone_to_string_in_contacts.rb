class ChangePhoneToStringInContacts < ActiveRecord::Migration[8.0]
  def change
    change_column :contacts, :phone, :string
  end
end

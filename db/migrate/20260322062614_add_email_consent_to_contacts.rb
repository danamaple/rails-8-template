class AddEmailConsentToContacts < ActiveRecord::Migration[8.0]
  def change
    add_column :contacts, :email_consent, :boolean
    add_column :contacts, :email_consent_date, :datetime
    add_column :contacts, :unsubscribed, :boolean
    add_column :contacts, :unsubscribed_date, :datetime
  end
end

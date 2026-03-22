# == Schema Information
#
# Table name: contacts
#
#  id                      :bigint           not null, primary key
#  email                   :string
#  email_consent           :boolean
#  email_consent_date      :datetime
#  first_name              :string
#  general_company_contact :boolean
#  last_name               :string
#  linkedin                :string
#  notes                   :text
#  phone                   :string
#  preferred_name          :string
#  title                   :string
#  unsubscribed            :boolean
#  unsubscribed_date       :datetime
#  created_at              :datetime         not null
#  updated_at              :datetime         not null
#  company_id              :integer
#
class Contact < ApplicationRecord
  has_many  :outreaches,   class_name: "Outreach",   foreign_key: "contact_id"
  has_many  :email_sends,  class_name: "EmailSend",  foreign_key: "contact_id"
  belongs_to :company, required: true, class_name: "Company", foreign_key: "company_id"

  def self.to_csv(records = all)
    headers = ["id", "first_name", "last_name", "preferred_name", "title", "email", "phone", "linkedin", "notes", "general_company_contact", "company_name"]
    csv = CSV.generate(headers: true) do |csv|
      csv << headers
      records.each do |contact|
        row = []
        row.push(contact.id)
        row.push(contact.first_name)
        row.push(contact.last_name)
        row.push(contact.preferred_name)
        row.push(contact.title)
        row.push(contact.email)
        row.push(contact.phone)
        row.push(contact.linkedin)
        row.push(contact.notes)
        row.push(contact.general_company_contact)
        row.push(contact.company&.company_name)
        csv << row
      end
    end
    return csv
  end
end

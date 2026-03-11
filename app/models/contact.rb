# == Schema Information
#
# Table name: contacts
#
#  id                      :bigint           not null, primary key
#  email                   :string
#  first_name              :string
#  general_company_contact :boolean
#  last_name               :string
#  linkedin                :string
#  notes                   :text
#  phone                   :string
#  preferred_name          :string
#  title                   :string
#  created_at              :datetime         not null
#  updated_at              :datetime         not null
#  company_id              :integer
#
class Contact < ApplicationRecord
  has_many  :outreaches, class_name: "Outreach", foreign_key: "contact_id"
  belongs_to :company, required: true, class_name: "Company", foreign_key: "company_id"

  def self.to_csv(records = all)
    CSV.generate(headers: true) do |csv|
      csv << ["id", "first_name", "last_name", "preferred_name", "title", "email", "phone", "linkedin", "notes", "general_company_contact", "company_name"]
      records.each do |contact|
        csv << [
          contact.id,
          contact.first_name,
          contact.last_name,
          contact.preferred_name,
          contact.title,
          contact.email,
          contact.phone,
          contact.linkedin,
          contact.notes,
          contact.general_company_contact,
          contact.company&.company_name
        ]
      end
    end
  end
end

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
end

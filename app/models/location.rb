# == Schema Information
#
# Table name: locations
#
#  id            :bigint           not null, primary key
#  location_type :string
#  name          :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  company_id    :integer
#
class Location < ApplicationRecord
  belongs_to :company, required: false, class_name: "Company", foreign_key: "company_id"
  has_many :lots, class_name: "Lot", foreign_key: "location_id", dependent: :destroy
end

# == Schema Information
#
# Table name: custom_fields
#
#  id         :bigint           not null, primary key
#  data_type  :string
#  field_name :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class CustomField < ApplicationRecord
  has_many :custom_field_values, class_name: "CustomFieldValue", foreign_key: "custom_field_id", dependent: :destroy
end

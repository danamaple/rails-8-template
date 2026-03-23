# == Schema Information
#
# Table name: custom_field_values
#
#  id              :bigint           not null, primary key
#  value           :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  custom_field_id :integer
#  product_id      :integer
#
class CustomFieldValue < ApplicationRecord
  belongs_to :product, required: true, class_name: "Product", foreign_key: "product_id"
  belongs_to :custom_field, required: true, class_name: "CustomField", foreign_key: "custom_field_id"
end

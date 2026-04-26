# == Schema Information
#
# Table name: email_template_products
#
#  id                :bigint           not null, primary key
#  position          :integer
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  email_template_id :integer
#  product_id        :integer
#
class EmailTemplateProduct < ApplicationRecord
  belongs_to :email_template, required: true, class_name: "EmailTemplate", foreign_key: "email_template_id"
  belongs_to :product, required: true, class_name: "Product", foreign_key: "product_id"
end

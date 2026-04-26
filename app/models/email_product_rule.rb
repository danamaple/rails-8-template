# == Schema Information
#
# Table name: email_product_rules
#
#  id                :bigint           not null, primary key
#  field             :string
#  measurement       :string
#  value             :string
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  email_template_id :integer
#
class EmailProductRule < ApplicationRecord
  belongs_to :email_template, required: true, class_name: "EmailTemplate", foreign_key: "email_template_id"
end

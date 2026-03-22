# == Schema Information
#
# Table name: email_sends
#
#  id                :bigint           not null, primary key
#  body              :text
#  status            :string
#  subject           :string
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  contact_id        :integer
#  email_template_id :integer
#  user_id           :integer
#
class EmailSend < ApplicationRecord
  belongs_to :contact,        required: true, class_name: "Contact",       foreign_key: "contact_id"
  belongs_to :email_template, required: true, class_name: "EmailTemplate", foreign_key: "email_template_id"
  belongs_to :user,           required: true, class_name: "User",          foreign_key: "user_id"
end

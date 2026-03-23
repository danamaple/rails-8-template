# == Schema Information
#
# Table name: smart_list_rules
#
#  id          :bigint           not null, primary key
#  field       :string
#  measurement :string
#  mode        :string
#  value       :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  list_id     :integer
#
class SmartListRule < ApplicationRecord
  belongs_to :list, required: true, class_name: "List", foreign_key: "list_id"
end

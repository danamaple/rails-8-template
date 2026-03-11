# == Schema Information
#
# Table name: list_memberships
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  company_id :integer
#  list_id    :integer
#
class ListMembership < ApplicationRecord
  belongs_to :company, required: true, class_name: "Company", foreign_key: "company_id"
  belongs_to :list, required: true, class_name: "List", foreign_key: "list_id", counter_cache: true
end

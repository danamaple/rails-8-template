# == Schema Information
#
# Table name: promotion_lists
#
#  id           :bigint           not null, primary key
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  list_id      :integer
#  promotion_id :integer
#
class PromotionList < ApplicationRecord
  belongs_to :promotion, required: true, class_name: "Promotion", foreign_key: "promotion_id"
  belongs_to :list, required: true, class_name: "List", foreign_key: "list_id"
end

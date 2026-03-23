# == Schema Information
#
# Table name: promotion_products
#
#  id           :bigint           not null, primary key
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  product_id   :integer
#  promotion_id :integer
#
class PromotionProduct < ApplicationRecord
  belongs_to :promotion, required: true, class_name: "Promotion", foreign_key: "promotion_id"
  belongs_to :product, required: true, class_name: "Product", foreign_key: "product_id"
end

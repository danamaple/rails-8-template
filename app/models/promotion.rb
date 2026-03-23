# == Schema Information
#
# Table name: promotions
#
#  id               :bigint           not null, primary key
#  buy_quantity     :integer
#  description      :text
#  discount_percent :decimal(, )
#  discount_type    :string
#  discount_value   :decimal(, )
#  end_date         :date
#  get_quantity     :integer
#  min_quantity     :integer
#  name             :string
#  start_date       :date
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#
class Promotion < ApplicationRecord
  has_many :promotion_products, class_name: "PromotionProduct", foreign_key: "promotion_id", dependent: :destroy
  has_many :products, through: :promotion_products, source: :product
  has_many :promotion_lists, class_name: "PromotionList", foreign_key: "promotion_id", dependent: :destroy
  has_many :lists, through: :promotion_lists, source: :list

  def discount_summary
    case discount_type
    when "percentage"
      text = "#{discount_value}% off"
    when "fixed"
      text = "$#{discount_value} off per unit"
    when "price_override"
      text = "$#{discount_value} per unit"
    when "bogo"
      text = "Buy #{buy_quantity}, get #{get_quantity} at #{discount_percent}% off"
    else
      text = "Discount"
    end
    if min_quantity.present? && min_quantity > 0
      text += " (min #{min_quantity} units)"
    end
    text
  end
end

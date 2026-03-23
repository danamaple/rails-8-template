# == Schema Information
#
# Table name: price_categories
#
#  id         :bigint           not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class PriceCategory < ApplicationRecord
  has_many :product_prices, class_name: "ProductPrice", foreign_key: "price_category_id"
end

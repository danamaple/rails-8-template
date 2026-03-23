# == Schema Information
#
# Table name: product_prices
#
#  id                :bigint           not null, primary key
#  max_quantity      :integer
#  min_quantity      :integer
#  unit_price        :decimal(, )
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  price_category_id :integer
#  product_id        :integer
#
class ProductPrice < ApplicationRecord
  belongs_to :product, required: true, class_name: "Product", foreign_key: "product_id"
  belongs_to :price_category, required: true, class_name: "PriceCategory", foreign_key: "price_category_id"
end

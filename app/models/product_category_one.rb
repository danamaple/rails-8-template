# == Schema Information
#
# Table name: product_category_ones
#
#  id         :bigint           not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class ProductCategoryOne < ApplicationRecord
  has_many :product_category_twos, class_name: "ProductCategoryTwo", foreign_key: "product_category_one_id"
  has_many :products, class_name: "Product", foreign_key: "product_category_one_id"
end

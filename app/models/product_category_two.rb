# == Schema Information
#
# Table name: product_category_twos
#
#  id                      :bigint           not null, primary key
#  name                    :string
#  created_at              :datetime         not null
#  updated_at              :datetime         not null
#  product_category_one_id :integer
#
class ProductCategoryTwo < ApplicationRecord
  belongs_to :product_category_one, required: true, class_name: "ProductCategoryOne", foreign_key: "product_category_one_id"
  has_many :product_category_threes, class_name: "ProductCategoryThree", foreign_key: "product_category_two_id"
  has_many :products, class_name: "Product", foreign_key: "product_category_two_id"
end

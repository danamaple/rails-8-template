# == Schema Information
#
# Table name: product_category_threes
#
#  id                      :bigint           not null, primary key
#  name                    :string
#  created_at              :datetime         not null
#  updated_at              :datetime         not null
#  product_category_two_id :integer
#
class ProductCategoryThree < ApplicationRecord
  belongs_to :product_category_two, required: true, class_name: "ProductCategoryTwo", foreign_key: "product_category_two_id"
  has_many :products, class_name: "Product", foreign_key: "product_category_three_id"
end

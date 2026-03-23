# == Schema Information
#
# Table name: products
#
#  id                        :bigint           not null, primary key
#  description               :text
#  flavour                   :string
#  frontend_name             :string
#  image_url                 :string
#  inventory_level           :integer
#  is_active                 :boolean
#  name                      :string
#  new_arrival               :boolean
#  new_arrival_date          :date
#  reorder_point             :integer
#  reorder_quantity          :integer
#  retail_price              :decimal(, )
#  size                      :string
#  sku                       :string
#  supply_price              :decimal(, )
#  track_inventory           :boolean
#  upc                       :string
#  weight                    :string
#  created_at                :datetime         not null
#  updated_at                :datetime         not null
#  brand_id                  :integer
#  product_category_one_id   :integer
#  product_category_three_id :integer
#  product_category_two_id   :integer
#  supplier_id               :integer
#
class Product < ApplicationRecord
  belongs_to :brand, required: false, class_name: "Brand", foreign_key: "brand_id"
  belongs_to :supplier, required: false, class_name: "Supplier", foreign_key: "supplier_id"
  belongs_to :product_category_one, required: false, class_name: "ProductCategoryOne", foreign_key: "product_category_one_id"
  belongs_to :product_category_two, required: false, class_name: "ProductCategoryTwo", foreign_key: "product_category_two_id"
  belongs_to :product_category_three, required: false, class_name: "ProductCategoryThree", foreign_key: "product_category_three_id"
  has_many :custom_field_values, class_name: "CustomFieldValue", foreign_key: "product_id", dependent: :destroy
  has_many :product_prices, class_name: "ProductPrice", foreign_key: "product_id", dependent: :destroy
  has_many :customer_prices, class_name: "CustomerPrice", foreign_key: "product_id", dependent: :destroy
  has_many :promotion_products, class_name: "PromotionProduct", foreign_key: "product_id"
  has_many :promotions, through: :promotion_products, source: :promotion
end

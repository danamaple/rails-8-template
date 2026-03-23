# == Schema Information
#
# Table name: customer_prices
#
#  id           :bigint           not null, primary key
#  max_quantity :integer
#  min_quantity :integer
#  unit_price   :decimal(, )
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  company_id   :integer
#  product_id   :integer
#
class CustomerPrice < ApplicationRecord
  belongs_to :product, required: true, class_name: "Product", foreign_key: "product_id"
  belongs_to :company, required: true, class_name: "Company", foreign_key: "company_id"
end

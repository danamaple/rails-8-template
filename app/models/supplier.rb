# == Schema Information
#
# Table name: suppliers
#
#  id           :bigint           not null, primary key
#  contact_name :string
#  email        :string
#  name         :string
#  phone        :string
#  website      :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
class Supplier < ApplicationRecord
  has_many :products, class_name: "Product", foreign_key: "supplier_id"
end

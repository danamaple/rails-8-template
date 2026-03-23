# == Schema Information
#
# Table name: lots
#
#  id            :bigint           not null, primary key
#  expiry_date   :date
#  lot_number    :string
#  quantity      :integer
#  received_date :date
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  location_id   :integer
#  product_id    :integer
#  supplier_id   :integer
#
class Lot < ApplicationRecord
  belongs_to :product, required: true, class_name: "Product", foreign_key: "product_id"
  belongs_to :location, required: true, class_name: "Location", foreign_key: "location_id"
  belongs_to :supplier, required: false, class_name: "Supplier", foreign_key: "supplier_id"
  has_many :inventory_removals, class_name: "InventoryRemoval", foreign_key: "lot_id", dependent: :destroy
end

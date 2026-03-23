# == Schema Information
#
# Table name: inventory_removals
#
#  id           :bigint           not null, primary key
#  notes        :text
#  quantity     :integer
#  reason       :string
#  removed_date :date
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  lot_id       :integer
#
class InventoryRemoval < ApplicationRecord
  belongs_to :lot, required: true, class_name: "Lot", foreign_key: "lot_id"
end

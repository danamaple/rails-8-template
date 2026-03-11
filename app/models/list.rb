# == Schema Information
#
# Table name: lists
#
#  id                     :bigint           not null, primary key
#  list_memberships_count :integer
#  name                   :string
#  notes                  :text
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
class List < ApplicationRecord
  has_many :list_memberships, class_name: "ListMembership", foreign_key: "list_id"
  has_many :companies, through: :list_memberships, source: :company

  def self.to_csv(records = all)
    headers = ["id", "name", "notes"]
    csv = CSV.generate(headers: true) do |csv|
      csv << headers
      records.each do |list|
        row = []
        row.push(list.id)
        row.push(list.name)
        row.push(list.notes)
        csv << row
      end
    end
    return csv
  end
end

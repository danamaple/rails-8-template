# == Schema Information
#
# Table name: categories
#
#  id               :bigint           not null, primary key
#  category         :string
#  portfolios_count :integer
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#
class Category < ApplicationRecord
  has_many  :portfolios, class_name: "Portfolio", foreign_key: "category_id"
  has_many :companies, through: :portfolios, source: :company

  def self.to_csv(records = all)
    headers = ["id", "category"]
    csv = CSV.generate(headers: true) do |csv|
      csv << headers
      records.each do |category|
        row = []
        row.push(category.id)
        row.push(category.category)
        csv << row
      end
    end
    return csv
  end
end

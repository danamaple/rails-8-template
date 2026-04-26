# == Schema Information
#
# Table name: companies
#
#  id                :bigint           not null, primary key
#  company_name      :string
#  notes             :text
#  portfolios_count  :integer
#  status            :string
#  website           :string
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  price_category_id :integer
#
class Company < ApplicationRecord
  has_many  :portfolios, class_name: "Portfolio", foreign_key: "company_id"
  has_many  :contacts, class_name: "Contact", foreign_key: "company_id"
  has_many :categories, through: :portfolios, source: :category
  has_many :list_memberships, class_name: "ListMembership", foreign_key: "company_id"
  has_many :lists, through: :list_memberships, source: :list
  has_many :customer_prices, class_name: "CustomerPrice", foreign_key: "company_id"
  has_many :locations, class_name: "Location", foreign_key: "company_id"
  belongs_to :price_category, required: false, class_name: "PriceCategory", foreign_key: "price_category_id"

  def self.to_csv(records = all)
    headers = ["id", "company_name", "website", "status", "notes", "categories", "lists"]
    csv = CSV.generate(headers: true) do |csv|
      csv << headers
      records.each do |company|
        row = []
        row.push(company.id)
        row.push(company.company_name)
        row.push(company.website)
        row.push(company.status)
        row.push(company.notes)
        row.push(company.portfolios.map { |p| p.category.category }.join("; "))
        row.push(company.list_memberships.map { |m| m.list.name }.join("; "))
        csv << row
      end
    end
    return csv
  end
end

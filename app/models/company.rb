# == Schema Information
#
# Table name: companies
#
#  id               :bigint           not null, primary key
#  company_name     :string
#  notes            :text
#  portfolios_count :integer
#  status           :string
#  website          :string
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#
class Company < ApplicationRecord
  has_many  :portfolios, class_name: "Portfolio", foreign_key: "company_id"
  has_many  :contacts, class_name: "Contact", foreign_key: "company_id"
  has_many :categories, through: :portfolios, source: :category
  has_many :list_memberships, class_name: "ListMembership", foreign_key: "company_id"
  has_many :lists, through: :list_memberships, source: :list

  def self.to_csv(records = all)
    CSV.generate(headers: true) do |csv|
      csv << ["id", "company_name", "website", "status", "notes", "categories", "lists"]
      records.each do |company|
        csv << [
          company.id,
          company.company_name,
          company.website,
          company.status,
          company.notes,
          company.portfolios.map { |p| p.category.category }.join("; "),
          company.list_memberships.map { |m| m.list.name }.join("; ")
        ]
      end
    end
  end
end

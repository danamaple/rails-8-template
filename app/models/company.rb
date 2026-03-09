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
end

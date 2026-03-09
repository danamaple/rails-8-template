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
end

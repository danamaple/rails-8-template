# == Schema Information
#
# Table name: portfolios
#
#  id          :bigint           not null, primary key
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  category_id :integer
#  company_id  :integer
#
class Portfolio < ApplicationRecord
  belongs_to :company, required: true, class_name: "Company", foreign_key: "company_id", counter_cache: true
  belongs_to :category, required: true, class_name: "Category", foreign_key: "category_id", counter_cache: true
end

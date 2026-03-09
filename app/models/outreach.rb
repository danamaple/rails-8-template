# == Schema Information
#
# Table name: outreaches
#
#  id                :bigint           not null, primary key
#  notes             :text
#  outreach_datetime :datetime
#  outreach_medium   :string
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  contact_id        :integer
#  rep_id            :integer
#
class Outreach < ApplicationRecord
  belongs_to :contact, required: true, class_name: "Contact", foreign_key: "contact_id"
  belongs_to :rep, required: true, class_name: "User", foreign_key: "rep_id", counter_cache: true
end

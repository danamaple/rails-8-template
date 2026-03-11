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

  def self.to_csv(records = all)
    CSV.generate(headers: true) do |csv|
      csv << ["id", "outreach_datetime", "outreach_medium", "notes", "contact_email", "rep_email"]
      records.each do |outreach|
        csv << [
          outreach.id,
          outreach.outreach_datetime&.strftime("%Y-%m-%d %H:%M:%S"),
          outreach.outreach_medium,
          outreach.notes,
          outreach.contact&.email,
          outreach.rep&.email
        ]
      end
    end
  end
end

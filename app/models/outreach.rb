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
    headers = ["id", "outreach_datetime", "outreach_medium", "notes", "contact_email", "rep_email"]
    csv = CSV.generate(headers: true) do |csv|
      csv << headers
      records.each do |outreach|
        row = []
        row.push(outreach.id)
        row.push(outreach.outreach_datetime&.strftime("%Y-%m-%d %H:%M:%S"))
        row.push(outreach.outreach_medium)
        row.push(outreach.notes)
        row.push(outreach.contact&.email)
        row.push(outreach.rep&.email)
        csv << row
      end
    end
    return csv
  end
end

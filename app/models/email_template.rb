# == Schema Information
#
# Table name: email_templates
#
#  id         :bigint           not null, primary key
#  body       :text
#  name       :string
#  subject    :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class EmailTemplate < ApplicationRecord
  has_many :email_sends, class_name: "EmailSend", foreign_key: "email_template_id"

  def render_for(contact, sender)
    merged_subject = subject.dup
    merged_body = body.dup

    replacements = {
      "{{company_name}}"  => contact.company.company_name,
      "{{first_name}}"    => contact.first_name,
      "{{last_name}}"     => contact.last_name,
      "{{title}}"         => contact.title,
      "{{rep_first_name}}" => sender.first_name,
      "{{rep_last_name}}"  => sender.last_name
    }

    replacements.each do |placeholder, value|
      merged_subject.gsub!(placeholder, value.to_s)
      merged_body.gsub!(placeholder, value.to_s)
    end

    { :subject => merged_subject, :body => merged_body }
  end

  def self.to_csv(records = all)
    headers = ["id", "name", "subject", "body"]
    csv = CSV.generate(headers: true) do |csv|
      csv << headers
      records.each do |t|
        csv << [t.id, t.name, t.subject, t.body]
      end
    end
    return csv
  end
end

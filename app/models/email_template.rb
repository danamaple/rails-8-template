# == Schema Information
#
# Table name: email_templates
#
#  id          :bigint           not null, primary key
#  body        :text
#  name        :string
#  show_prices :boolean
#  subject     :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
class EmailTemplate < ApplicationRecord
  has_many :email_sends, class_name: "EmailSend", foreign_key: "email_template_id"
  has_many :email_template_products, class_name: "EmailTemplateProduct", foreign_key: "email_template_id", dependent: :destroy
  has_many :products, through: :email_template_products, source: :product

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

    template_products = email_template_products.includes(:product => [:brand, :product_prices]).order(:position)
    if template_products.any?
      merged_body += render_products_html(template_products, contact.company)
    end

    { :subject => merged_subject, :body => merged_body }
  end

  def render_products_html(template_products, company)
    price_category_id = company&.price_category_id

    rows_html = ""
    template_products.each_slice(4) do |slice|
      cells = slice.map do |etp|
        p = etp.product
        img_html = p.image_url.present? ? "<img src=\"#{p.image_url}\" style=\"max-width:120px; max-height:120px; display:block; margin:0 auto 8px;\">" : ""
        brand_name = p.brand&.name.to_s
        size_str = p.size.to_s

        price_html = ""
        if show_prices
          price = nil
          if price_category_id.present?
            pp = p.product_prices.find { |x| x.price_category_id == price_category_id }
            price = pp&.unit_price
          end
          price = p.retail_price if price.nil?
          price_html = "<div style=\"margin-top:4px; font-weight:bold;\">$#{sprintf('%.2f', price.to_f)}</div>" if price.present?
        end

        "<td style=\"padding:12px; text-align:center; vertical-align:top; width:25%;\">#{img_html}<div style=\"font-weight:bold;\">#{p.name}</div><div style=\"color:#666; font-size:0.9em;\">#{brand_name}</div><div style=\"color:#888; font-size:0.85em;\">#{size_str}</div>#{price_html}</td>"
      end
      while cells.length < 4
        cells << "<td style=\"padding:12px; width:25%;\"></td>"
      end
      rows_html += "<tr>#{cells.join}</tr>"
    end

    "<table style=\"width:100%; border-collapse:collapse; margin-top:16px;\"><tbody>#{rows_html}</tbody></table>"
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

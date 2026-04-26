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
  has_many :email_product_rules, class_name: "EmailProductRule", foreign_key: "email_template_id", dependent: :destroy

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

    manual_products = email_template_products.includes(:product => [:brand, :product_prices]).order(:position)
    rule_products = rule_matched_products.includes(:brand, :product_prices)

    all_product_ids = manual_products.map { |etp| etp.product_id } + rule_products.pluck(:id)
    all_product_ids = all_product_ids.uniq

    if all_product_ids.any?
      ordered_products = []
      manual_products.each { |etp| ordered_products << etp.product }
      rule_products.each { |p| ordered_products << p unless ordered_products.include?(p) }
      merged_body += render_products_html_from_list(ordered_products, contact.company)
    end

    { :subject => merged_subject, :body => merged_body }
  end

  def rule_matched_products
    return Product.none if email_product_rules.empty?

    scope = Product.where(:is_active => true)

    email_product_rules.each do |rule|
      case rule.field
      when "new_arrival"
        scope = scope.where(:new_arrival => rule.value == "true")
      when "product_category_one"
        scope = scope.joins(:product_category_one).where("product_category_ones.name ILIKE ?", rule.value)
      when "product_category_two"
        scope = scope.joins(:product_category_two).where("product_category_twos.name ILIKE ?", rule.value)
      when "brand"
        scope = scope.joins(:brand).where("brands.name ILIKE ?", rule.value)
      when "supplier"
        scope = scope.joins(:supplier).where("suppliers.name ILIKE ?", rule.value)
      when "name_contains"
        scope = scope.where("products.name ILIKE ?", "%#{rule.value}%")
      when "retail_price_less_than"
        scope = scope.where("products.retail_price < ?", rule.value.to_f)
      when "retail_price_greater_than"
        scope = scope.where("products.retail_price > ?", rule.value.to_f)
      when "added_within_days"
        scope = scope.where("products.created_at > ?", rule.value.to_i.days.ago)
      end
    end

    scope
  end

  def render_products_html_from_list(products, company)
    html = '<br><table style="width: 100%; border-collapse: collapse;"><tr>'

    products.each_with_index do |product, i|
      link = product.product_url.present? ? product.product_url : "#"

      html += '<td style="padding: 10px; text-align: center; vertical-align: top; width: 25%;">'
      html += "<a href=\"#{link}\" style=\"text-decoration: none; color: inherit;\" target=\"_blank\">"

      if product.image_url.present?
        html += "<img src=\"#{product.image_url}\" style=\"max-width: 140px; max-height: 140px; display: block; margin: 0 auto 8px; border-radius: 4px;\">"
      else
        html += '<div style="width: 140px; height: 140px; background: #f0f0f0; border-radius: 4px; margin: 0 auto 8px; display: flex; align-items: center; justify-content: center; color: #999;">No image</div>'
      end

      html += "<div style=\"font-weight: bold; font-size: 14px;\">#{product.name}</div>"
      html += "<div style=\"color: #666; font-size: 12px;\">#{product.brand&.name}</div>"
      html += "<div style=\"color: #666; font-size: 12px;\">#{product.size}</div>"

      if show_prices
        price = product.retail_price
        if company&.price_category_id.present?
          pp = product.product_prices.find { |p| p.price_category_id == company.price_category_id && (p.min_quantity.nil? || p.min_quantity <= 1) }
          price = pp.unit_price if pp
        end
        html += "<div style=\"font-weight: bold; font-size: 16px; margin-top: 4px;\">$#{'%.2f' % price}</div>" if price.present?
      end

      html += "</a></td>"

      if (i + 1) % 4 == 0 && i + 1 < products.length
        html += '</tr><tr>'
      end
    end

    html += '</tr></table>'
    html
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

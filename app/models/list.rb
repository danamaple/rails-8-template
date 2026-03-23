# == Schema Information
#
# Table name: lists
#
#  id                     :bigint           not null, primary key
#  list_memberships_count :integer
#  name                   :string
#  notes                  :text
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
class List < ApplicationRecord
  has_many :list_memberships, class_name: "ListMembership", foreign_key: "list_id"
  has_many :companies, through: :list_memberships, source: :company
  has_many :smart_list_rules, class_name: "SmartListRule", foreign_key: "list_id", dependent: :destroy
  has_many :promotion_lists, class_name: "PromotionList", foreign_key: "list_id"
  has_many :promotions, through: :promotion_lists, source: :promotion
  has_many :list_exclusions, class_name: "ListExclusion", foreign_key: "list_id", dependent: :destroy

  def all_companies
    manual = companies
    if smart_list_rules.any?
      rule_matched = self.class.evaluate_rules(smart_list_rules)
      combined = Company.where(:id => manual.pluck(:id) + rule_matched.pluck(:id)).distinct
    else
      combined = manual
    end
    excluded_ids = list_exclusions.pluck(:company_id)
    if excluded_ids.any?
      combined = combined.where.not(:id => excluded_ids)
    end
    combined
  end

  def self.evaluate_rules(rules)
    scope = Company.all
    rules.each do |rule|
      scope = apply_rule(scope, rule)
    end
    scope
  end

  def self.apply_rule(scope, rule)
    field       = rule.field
    measurement = rule.measurement
    value       = rule.value

    case field
    when "status"
      case measurement
      when "equals"        then scope.where("companies.status ILIKE ?", value)
      when "not_equals"    then scope.where("companies.status NOT ILIKE ?", value)
      when "contains"      then scope.where("companies.status ILIKE ?", "%#{value}%")
      when "is_blank"      then scope.where("companies.status IS NULL OR companies.status = ''")
      when "is_not_blank"  then scope.where("companies.status IS NOT NULL AND companies.status != ''")
      else scope
      end
    when "company_name"
      case measurement
      when "equals"     then scope.where("companies.company_name ILIKE ?", value)
      when "not_equals" then scope.where("companies.company_name NOT ILIKE ?", value)
      when "contains"   then scope.where("companies.company_name ILIKE ?", "%#{value}%")
      else scope
      end
    when "website"
      case measurement
      when "contains"     then scope.where("companies.website ILIKE ?", "%#{value}%")
      when "is_blank"     then scope.where("companies.website IS NULL OR companies.website = ''")
      when "is_not_blank" then scope.where("companies.website IS NOT NULL AND companies.website != ''")
      else scope
      end
    when "category"
      case measurement
      when "equals"
        scope.joins(:portfolios => :category).where("categories.category ILIKE ?", value)
      else scope
      end
    when "contact_count"
      subquery = "(SELECT COUNT(*) FROM contacts WHERE contacts.company_id = companies.id)"
      case measurement
      when "equals"       then scope.where("#{subquery} = ?", value.to_i)
      when "greater_than" then scope.where("#{subquery} > ?", value.to_i)
      when "less_than"    then scope.where("#{subquery} < ?", value.to_i)
      else scope
      end
    when "total_outreaches"
      subquery = "(SELECT COUNT(*) FROM outreaches JOIN contacts ON contacts.id = outreaches.contact_id WHERE contacts.company_id = companies.id)"
      case measurement
      when "equals"       then scope.where("#{subquery} = ?", value.to_i)
      when "greater_than" then scope.where("#{subquery} > ?", value.to_i)
      when "less_than"    then scope.where("#{subquery} < ?", value.to_i)
      else scope
      end
    when "most_recent_outreach"
      subquery = "(SELECT MAX(outreaches.outreach_datetime) FROM outreaches JOIN contacts ON contacts.id = outreaches.contact_id WHERE contacts.company_id = companies.id)"
      case measurement
      when "days_ago_more_than" then scope.where("#{subquery} < ?", value.to_i.days.ago)
      when "days_ago_less_than" then scope.where("#{subquery} > ?", value.to_i.days.ago)
      when "is_blank"           then scope.where("#{subquery} IS NULL")
      else scope
      end
    when "outreach_medium"
      case measurement
      when "equals"
        scope.where("EXISTS (SELECT 1 FROM outreaches JOIN contacts ON contacts.id = outreaches.contact_id WHERE contacts.company_id = companies.id AND outreaches.outreach_medium ILIKE ?)", value)
      else scope
      end
    else
      scope
    end
  end

  def self.to_csv(records = all)
    headers = ["id", "name", "notes"]
    csv = CSV.generate(headers: true) do |csv|
      csv << headers
      records.each do |list|
        row = []
        row.push(list.id)
        row.push(list.name)
        row.push(list.notes)
        csv << row
      end
    end
    return csv
  end
end

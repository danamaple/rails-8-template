class AdminController < ApplicationController
  before_action :require_admin

  TEMPLATE_HEADERS = {
    "companies"  => ["company_name", "website", "status", "notes"],
    "contacts"   => ["first_name", "last_name", "preferred_name", "title", "email", "phone", "linkedin", "notes", "general_company_contact", "company_name"],
    "outreaches" => ["outreach_datetime", "outreach_medium", "notes", "contact_email", "rep_email"],
    "categories" => ["category"],
    "lists"      => ["name", "notes"]
  }.freeze

  def import
    # GET — show the import page
  end

  def do_import
    table = params[:table]
    file  = params[:csv_file]

    unless file.present?
      redirect_to "/admin/import", alert: "Please select a CSV file."
      return
    end

    successes = 0
    failures  = 0

    begin
      CSV.parse(file.read, headers: true) do |row|
        case table
        when "companies"
          next if row["company_name"].blank?
          c = Company.new(
            company_name: row["company_name"],
            website:      row["website"],
            status:       row["status"],
            notes:        row["notes"]
          )
          c.save ? successes += 1 : failures += 1

        when "contacts"
          next if row["first_name"].blank? && row["last_name"].blank?
          company = Company.find_by(company_name: row["company_name"])
          unless company
            failures += 1
            next
          end
          c = Contact.new(
            company_id:              company.id,
            first_name:              row["first_name"],
            last_name:               row["last_name"],
            preferred_name:          row["preferred_name"],
            title:                   row["title"],
            email:                   row["email"],
            phone:                   row["phone"],
            linkedin:                row["linkedin"],
            notes:                   row["notes"],
            general_company_contact: row["general_company_contact"].to_s.downcase == "true"
          )
          c.save ? successes += 1 : failures += 1

        when "outreaches"
          next if row["contact_email"].blank? || row["rep_email"].blank?
          contact = Contact.find_by(email: row["contact_email"])
          rep     = User.find_by(email: row["rep_email"])
          unless contact && rep
            failures += 1
            next
          end
          datetime = row["outreach_datetime"].present? ? DateTime.parse(row["outreach_datetime"]) : nil
          o = Outreach.new(
            contact_id:       contact.id,
            rep_id:           rep.id,
            outreach_datetime: datetime,
            outreach_medium:  row["outreach_medium"],
            notes:            row["notes"]
          )
          o.save ? successes += 1 : failures += 1

        when "categories"
          next if row["category"].blank?
          c = Category.new(category: row["category"])
          c.save ? successes += 1 : failures += 1

        when "lists"
          next if row["name"].blank?
          l = List.new(name: row["name"], notes: row["notes"])
          l.save ? successes += 1 : failures += 1
        end
      end
    rescue => e
      redirect_to "/admin/import", alert: "Error parsing CSV: #{e.message}"
      return
    end

    model_label = table.humanize.downcase
    msg = "Imported #{successes} #{model_label}."
    msg += " #{failures} rows skipped due to errors." if failures > 0
    redirect_to "/admin/import", notice: msg
  end

  def template
    table   = params[:table]
    headers = TEMPLATE_HEADERS[table] || []
    csv_data = CSV.generate { |csv| csv << headers }
    send_data csv_data, filename: "#{table}-template.csv", type: "text/csv"
  end

  private

  def require_admin
    unless current_user&.role == "admin"
      redirect_to "/companies", alert: "You must be an admin to access that page."
    end
  end
end

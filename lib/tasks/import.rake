require "csv"

namespace :import do
  desc "Import all seed data from CSV files (safe to run twice — skips if records exist)"
  task all: :environment do
    if User.any? || Company.any? || Contact.any? || Outreach.any?
      puts "Records already exist. Skipping import."
      next
    end

    ActiveRecord::Base.transaction do
      # ----- Users -----
      puts "Creating users..."
      User.create!(id: 1, first_name: "Dan",     last_name: "Rowe",    email: "dan.rowe@inzollo.com",     password: "password123", role: "admin")
      User.create!(id: 2, first_name: "Kaitlyn", last_name: "Persaud", email: "kaitlyn.persaud@inzollo.com", password: "password123", role: "rep")
      User.create!(id: 3, first_name: "Foch",    last_name: "Lovejoy", email: "foch.lovejoy@inzollo.com",  password: "password123", role: "rep")
      ActiveRecord::Base.connection.reset_pk_sequence!("users")
      puts "  Created #{User.count} users."

      # ----- Companies -----
      puts "Importing companies..."
      companies_by_id = {}
      CSV.foreach(Rails.root.join("db/seed_data/companies.csv"), headers: true) do |row|
        companies_by_id[row["id"].to_i] = row
      end
      companies_by_id.each_value do |row|
        Company.create!(
          id:           row["id"].to_i,
          company_name: row["company_name"].presence,
          website:      row["website"].presence,
          status:       row["status"].presence,
          notes:        row["notes"].presence
        )
      end
      ActiveRecord::Base.connection.reset_pk_sequence!("companies")
      puts "  Imported #{Company.count} companies."

      # ----- Contacts -----
      puts "Importing contacts..."
      CSV.foreach(Rails.root.join("db/seed_data/contacts.csv"), headers: true) do |row|
        Contact.create!(
          id:                      row["id"].to_i,
          company_id:              row["company_id"].to_i,
          first_name:              row["first_name"].presence,
          last_name:               row["last_name"].presence,
          preferred_name:          row["preferred_name"].presence,
          title:                   row["title"].presence,
          email:                   row["email"].presence,
          phone:                   row["phone"].presence,
          linkedin:                row["linkedin"].presence,
          notes:                   row["notes"].presence,
          general_company_contact: row["general_company_contact"] == "true"
        )
      end
      ActiveRecord::Base.connection.reset_pk_sequence!("contacts")
      puts "  Imported #{Contact.count} contacts."

      # ----- Outreaches -----
      puts "Importing outreaches..."
      CSV.foreach(Rails.root.join("db/seed_data/outreaches.csv"), headers: true) do |row|
        Outreach.create!(
          id:                row["id"].to_i,
          contact_id:        row["contact_id"].to_i,
          outreach_datetime: begin
                               DateTime.parse(row["outreach_datetime"]) if row["outreach_datetime"].present?
                             rescue Date::Error, ArgumentError
                               nil
                             end,
          outreach_medium:   row["outreach_medium"].presence,
          rep_id:            row["rep_id"].to_i,
          notes:             row["notes"].presence
        )
      end
      ActiveRecord::Base.connection.reset_pk_sequence!("outreaches")
      puts "  Imported #{Outreach.count} outreaches."
    end

    puts "Done!"
  end
end

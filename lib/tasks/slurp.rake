require "csv"

namespace :slurp do
  desc "Import companies from lib/csvs/companies.csv"
  task companies: :environment do
    csv_text = File.read(Rails.root.join("lib", "csvs", "companies.csv"))
    csv = CSV.parse(csv_text, :headers => true, :encoding => "ISO-8859-1")
    csv.each do |row|
      c = Company.new
      c.company_name = row["company_name"]
      c.website = row["website"]
      c.status = row["status"]
      c.notes = row["notes"]
      c.save
      puts "#{c.company_name} saved"
    end
    puts "There are now #{Company.count} rows in the companies table"
  end

  desc "Import categories from lib/csvs/categories.csv"
  task categories: :environment do
    csv_text = File.read(Rails.root.join("lib", "csvs", "categories.csv"))
    csv = CSV.parse(csv_text, :headers => true, :encoding => "ISO-8859-1")
    csv.each do |row|
      c = Category.new
      c.category = row["category"]
      c.save
      puts "#{c.category} saved"
    end
    puts "There are now #{Category.count} rows in the categories table"
  end

  desc "Import lists from lib/csvs/lists.csv"
  task lists: :environment do
    csv_text = File.read(Rails.root.join("lib", "csvs", "lists.csv"))
    csv = CSV.parse(csv_text, :headers => true, :encoding => "ISO-8859-1")
    csv.each do |row|
      l = List.new
      l.name = row["name"]
      l.notes = row["notes"]
      l.save
      puts "#{l.name} saved"
    end
    puts "There are now #{List.count} rows in the lists table"
  end

  desc "Import contacts from lib/csvs/contacts.csv"
  task contacts: :environment do
    csv_text = File.read(Rails.root.join("lib", "csvs", "contacts.csv"))
    csv = CSV.parse(csv_text, :headers => true, :encoding => "ISO-8859-1")
    csv.each do |row|
      c = Contact.new
      c.company_id = row["company_id"]
      c.first_name = row["first_name"]
      c.last_name = row["last_name"]
      c.preferred_name = row["preferred_name"]
      c.title = row["title"]
      c.email = row["email"]
      c.phone = row["phone"]
      c.linkedin = row["linkedin"]
      c.notes = row["notes"]
      c.general_company_contact = row["general_company_contact"] == "true"
      c.save
      puts "#{c.first_name} #{c.last_name} saved"
    end
    puts "There are now #{Contact.count} rows in the contacts table"
  end

  desc "Import portfolios from lib/csvs/portfolios.csv"
  task portfolios: :environment do
    csv_text = File.read(Rails.root.join("lib", "csvs", "portfolios.csv"))
    csv = CSV.parse(csv_text, :headers => true, :encoding => "ISO-8859-1")
    csv.each do |row|
      p = Portfolio.new
      p.company_id = row["company_id"]
      p.category_id = row["category_id"]
      p.save
      puts "Portfolio company #{p.company_id} → category #{p.category_id} saved"
    end
    puts "There are now #{Portfolio.count} rows in the portfolios table"
  end

  desc "Import list memberships from lib/csvs/list_memberships.csv"
  task list_memberships: :environment do
    csv_text = File.read(Rails.root.join("lib", "csvs", "list_memberships.csv"))
    csv = CSV.parse(csv_text, :headers => true, :encoding => "ISO-8859-1")
    csv.each do |row|
      m = ListMembership.new
      m.company_id = row["company_id"]
      m.list_id = row["list_id"]
      m.save
      puts "ListMembership company #{m.company_id} → list #{m.list_id} saved"
    end
    puts "There are now #{ListMembership.count} rows in the list_memberships table"
  end

  desc "Import outreaches from lib/csvs/outreaches.csv"
  task outreaches: :environment do
    csv_text = File.read(Rails.root.join("lib", "csvs", "outreaches.csv"))
    csv = CSV.parse(csv_text, :headers => true, :encoding => "ISO-8859-1")
    csv.each do |row|
      o = Outreach.new
      o.contact_id = row["contact_id"]
      o.rep_id = row["rep_id"]
      o.outreach_datetime = row["outreach_datetime"].present? ? DateTime.parse(row["outreach_datetime"]) : nil
      o.outreach_medium = row["outreach_medium"]
      o.notes = row["notes"]
      o.save
      puts "Outreach #{o.id} (#{o.outreach_medium}) saved"
    end
    puts "There are now #{Outreach.count} rows in the outreaches table"
  end

  desc "Seed sample locations"
  task locations: :environment do
    Location.find_or_create_by(:name => "Santa Fe Warehouse", :location_type => "warehouse")
    Location.find_or_create_by(:name => "Dallas Warehouse",   :location_type => "warehouse")
    Location.find_or_create_by(:name => "Las Vegas Warehouse", :location_type => "warehouse")
    Location.find_or_create_by(:name => "Truck 1",            :location_type => "transit")
    Location.find_or_create_by(:name => "Truck 2",            :location_type => "transit")
    puts "Created #{Location.count} locations"
  end

  desc "Import all tables in order: create users, then companies, categories, lists, contacts, portfolios, list_memberships, outreaches"
  task all: :environment do
    puts "Creating users..."
    User.create!(id: 1, first_name: "Dan",     last_name: "Rowe",    email: "dan.rowe@inzollo.com",        password: "password123", role: "admin")
    User.create!(id: 2, first_name: "Kaitlyn", last_name: "Persaud", email: "kaitlyn.persaud@inzollo.com", password: "password123", role: "rep")
    User.create!(id: 3, first_name: "Foch",    last_name: "Lovejoy", email: "foch.lovejoy@inzollo.com",    password: "password123", role: "rep")
    ActiveRecord::Base.connection.reset_pk_sequence!("users")
    puts "Created #{User.count} users."

    Rake::Task["slurp:companies"].invoke
    ActiveRecord::Base.connection.reset_pk_sequence!("companies")

    Rake::Task["slurp:categories"].invoke
    ActiveRecord::Base.connection.reset_pk_sequence!("categories")

    Rake::Task["slurp:lists"].invoke
    ActiveRecord::Base.connection.reset_pk_sequence!("lists")

    Rake::Task["slurp:contacts"].invoke
    ActiveRecord::Base.connection.reset_pk_sequence!("contacts")

    Rake::Task["slurp:portfolios"].invoke
    ActiveRecord::Base.connection.reset_pk_sequence!("portfolios")

    Rake::Task["slurp:list_memberships"].invoke
    ActiveRecord::Base.connection.reset_pk_sequence!("list_memberships")

    Rake::Task["slurp:outreaches"].invoke
    ActiveRecord::Base.connection.reset_pk_sequence!("outreaches")

    Rake::Task["slurp:locations"].invoke
    ActiveRecord::Base.connection.reset_pk_sequence!("locations")

    puts "Done! All tables imported."
  end
end

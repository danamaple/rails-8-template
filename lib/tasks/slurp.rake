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

  desc "Import brands from lib/csvs/brands.csv"
  task brands: :environment do
    csv_text = File.read(Rails.root.join("lib", "csvs", "brands.csv"))
    csv = CSV.parse(csv_text, :headers => true, :encoding => "ISO-8859-1")
    csv.each do |row|
      b = Brand.new
      b.id   = row["id"]
      b.name = row["name"]
      b.save
      puts "#{b.name} saved"
    end
    puts "There are now #{Brand.count} rows in the brands table"
  end

  desc "Import suppliers from lib/csvs/suppliers.csv"
  task suppliers: :environment do
    csv_text = File.read(Rails.root.join("lib", "csvs", "suppliers.csv"))
    csv = CSV.parse(csv_text, :headers => true, :encoding => "ISO-8859-1")
    csv.each do |row|
      s = Supplier.new
      s.id           = row["id"]
      s.name         = row["name"]
      s.contact_name = row["contact_name"]
      s.email        = row["email"]
      s.phone        = row["phone"]
      s.website      = row["website"]
      s.save
      puts "#{s.name} saved"
    end
    puts "There are now #{Supplier.count} rows in the suppliers table"
  end

  desc "Import product category ones from lib/csvs/product_category_ones.csv"
  task product_category_ones: :environment do
    csv_text = File.read(Rails.root.join("lib", "csvs", "product_category_ones.csv"))
    csv = CSV.parse(csv_text, :headers => true, :encoding => "ISO-8859-1")
    csv.each do |row|
      c = ProductCategoryOne.new
      c.id   = row["id"]
      c.name = row["name"]
      c.save
      puts "#{c.name} saved"
    end
    puts "There are now #{ProductCategoryOne.count} rows in the product_category_ones table"
  end

  desc "Import product category twos from lib/csvs/product_category_twos.csv"
  task product_category_twos: :environment do
    csv_text = File.read(Rails.root.join("lib", "csvs", "product_category_twos.csv"))
    csv = CSV.parse(csv_text, :headers => true, :encoding => "ISO-8859-1")
    csv.each do |row|
      c = ProductCategoryTwo.new
      c.id                      = row["id"]
      c.name                    = row["name"]
      c.product_category_one_id = row["product_category_one_id"]
      c.save
      puts "#{c.name} saved"
    end
    puts "There are now #{ProductCategoryTwo.count} rows in the product_category_twos table"
  end

  desc "Import product category threes from lib/csvs/product_category_threes.csv"
  task product_category_threes: :environment do
    csv_text = File.read(Rails.root.join("lib", "csvs", "product_category_threes.csv"))
    csv = CSV.parse(csv_text, :headers => true, :encoding => "ISO-8859-1")
    csv.each do |row|
      c = ProductCategoryThree.new
      c.id                      = row["id"]
      c.name                    = row["name"]
      c.product_category_two_id = row["product_category_two_id"]
      c.save
      puts "#{c.name} saved"
    end
    puts "There are now #{ProductCategoryThree.count} rows in the product_category_threes table"
  end

  desc "Import price categories from lib/csvs/price_categories.csv"
  task price_categories: :environment do
    csv_text = File.read(Rails.root.join("lib", "csvs", "price_categories.csv"))
    csv = CSV.parse(csv_text, :headers => true, :encoding => "ISO-8859-1")
    csv.each do |row|
      pc = PriceCategory.new
      pc.id   = row["id"]
      pc.name = row["name"]
      pc.save
      puts "#{pc.name} saved"
    end
    puts "There are now #{PriceCategory.count} rows in the price_categories table"
  end

  desc "Import products from lib/csvs/products.csv"
  task products: :environment do
    csv_text = File.read(Rails.root.join("lib", "csvs", "products.csv"))
    csv = CSV.parse(csv_text, :headers => true, :encoding => "ISO-8859-1")
    csv.each do |row|
      p = Product.new
      p.id                        = row["id"]
      p.sku                       = row["sku"]
      p.name                      = row["name"]
      p.description               = row["description"]
      p.frontend_name             = row["frontend_name"]
      p.upc                       = row["upc"]
      p.flavour                   = row["flavour"]
      p.size                      = row["size"]
      p.weight                    = row["weight"]
      p.supply_price              = row["supply_price"]
      p.retail_price              = row["retail_price"]
      p.is_active                 = row["is_active"] == "true"
      p.new_arrival               = row["new_arrival"] == "true"
      p.image_url                 = row["image_url"]
      p.inventory_level           = row["inventory_level"]
      p.track_inventory           = row["track_inventory"] == "true"
      p.reorder_quantity          = row["reorder_quantity"]
      p.reorder_point             = row["reorder_point"]
      p.brand_id                  = row["brand_id"]
      p.supplier_id               = row["supplier_id"]
      p.product_category_one_id   = row["product_category_one_id"]
      p.product_category_two_id   = row["product_category_two_id"]
      p.product_category_three_id = row["product_category_three_id"]
      p.save
      puts "#{p.name} saved"
    end
    puts "There are now #{Product.count} rows in the products table"
  end

  desc "Import product prices from lib/csvs/product_prices.csv"
  task product_prices: :environment do
    csv_text = File.read(Rails.root.join("lib", "csvs", "product_prices.csv"))
    csv = CSV.parse(csv_text, :headers => true, :encoding => "ISO-8859-1")
    csv.each do |row|
      pp = ProductPrice.new
      pp.id                = row["id"]
      pp.product_id        = row["product_id"]
      pp.price_category_id = row["price_category_id"]
      pp.min_quantity      = row["min_quantity"]
      pp.max_quantity      = row["max_quantity"]
      pp.unit_price        = row["unit_price"]
      pp.save
      puts "ProductPrice ##{pp.id} saved"
    end
    puts "There are now #{ProductPrice.count} rows in the product_prices table"
  end

  desc "Import lots from lib/csvs/lots.csv"
  task lots: :environment do
    csv_text = File.read(Rails.root.join("lib", "csvs", "lots.csv"))
    csv = CSV.parse(csv_text, :headers => true, :encoding => "ISO-8859-1")
    csv.each do |row|
      l = Lot.new
      l.id            = row["id"]
      l.product_id    = row["product_id"]
      l.location_id   = row["location_id"]
      l.supplier_id   = row["supplier_id"]
      l.lot_number    = row["lot_number"]
      l.quantity      = row["quantity"]
      l.expiry_date   = row["expiry_date"]
      l.received_date = row["received_date"]
      l.save
      puts "Lot #{l.lot_number} saved"
    end
    puts "There are now #{Lot.count} rows in the lots table"
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

    Rake::Task["slurp:brands"].invoke
    ActiveRecord::Base.connection.reset_pk_sequence!("brands")

    Rake::Task["slurp:suppliers"].invoke
    ActiveRecord::Base.connection.reset_pk_sequence!("suppliers")

    Rake::Task["slurp:product_category_ones"].invoke
    ActiveRecord::Base.connection.reset_pk_sequence!("product_category_ones")

    Rake::Task["slurp:product_category_twos"].invoke
    ActiveRecord::Base.connection.reset_pk_sequence!("product_category_twos")

    Rake::Task["slurp:product_category_threes"].invoke
    ActiveRecord::Base.connection.reset_pk_sequence!("product_category_threes")

    Rake::Task["slurp:price_categories"].invoke
    ActiveRecord::Base.connection.reset_pk_sequence!("price_categories")

    Rake::Task["slurp:products"].invoke
    ActiveRecord::Base.connection.reset_pk_sequence!("products")

    Rake::Task["slurp:product_prices"].invoke
    ActiveRecord::Base.connection.reset_pk_sequence!("product_prices")

    Rake::Task["slurp:lots"].invoke
    ActiveRecord::Base.connection.reset_pk_sequence!("lots")

    puts "Done! All tables imported."
  end
end

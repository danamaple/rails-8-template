namespace :db do
  task reset_sequences: :environment do
    tables = ActiveRecord::Base.connection.tables
    tables.each do |table|
      next if table == "schema_migrations" || table == "ar_internal_metadata"
      ActiveRecord::Base.connection.execute("SELECT setval('#{table}_id_seq', COALESCE((SELECT MAX(id) FROM #{table}), 0) + 1, false)")
      puts "Reset sequence for #{table}"
    end
  end
end

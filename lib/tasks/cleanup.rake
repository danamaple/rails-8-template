namespace :cleanup do
  desc "Normalize company statuses to the five valid values"
  task statuses: :environment do
    valid_statuses = ["Cold", "Approaching", "Warm", "Converted", "Do Not Contact"]

    # "do not" (case insensitive), not already set correctly → "Do Not Contact"
    dnc_count = Company
      .where("status ILIKE ?", "%do not%")
      .where.not(status: "Do Not Contact")
      .update_all(status: "Do Not Contact")
    puts "  Do Not Contact: #{dnc_count} updated"

    # blank, nil, or anything not in the valid list → "Cold"
    cold_count = Company
      .where("status IS NULL OR status NOT IN (?)", valid_statuses)
      .update_all(status: "Cold")
    puts "  Cold: #{cold_count} updated"

    puts "Done."
  end
end

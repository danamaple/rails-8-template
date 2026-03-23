class CreateLocations < ActiveRecord::Migration[8.0]
  def change
    create_table :locations do |t|
      t.string :name
      t.string :location_type
      t.integer :company_id

      t.timestamps
    end
  end
end

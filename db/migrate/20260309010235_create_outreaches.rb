class CreateOutreaches < ActiveRecord::Migration[8.0]
  def change
    create_table :outreaches do |t|
      t.integer :contact_id
      t.datetime :outreach_datetime
      t.string :outreach_medium
      t.integer :rep_id
      t.text :notes

      t.timestamps
    end
  end
end

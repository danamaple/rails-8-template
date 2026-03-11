class CreateLists < ActiveRecord::Migration[8.0]
  def change
    create_table :lists do |t|
      t.string :name
      t.text :notes
      t.integer :list_memberships_count

      t.timestamps
    end
  end
end

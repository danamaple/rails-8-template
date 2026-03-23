class CreateInventoryRemovals < ActiveRecord::Migration[8.0]
  def change
    create_table :inventory_removals do |t|
      t.integer :lot_id
      t.integer :quantity
      t.string :reason
      t.date :removed_date
      t.text :notes

      t.timestamps
    end
  end
end

class CreateSmartListRules < ActiveRecord::Migration[8.0]
  def change
    create_table :smart_list_rules do |t|
      t.integer :list_id
      t.string :field
      t.string :measurement
      t.string :value

      t.timestamps
    end
  end
end

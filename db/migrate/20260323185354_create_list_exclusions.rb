class CreateListExclusions < ActiveRecord::Migration[8.0]
  def change
    create_table :list_exclusions do |t|
      t.integer :list_id
      t.integer :company_id

      t.timestamps
    end
  end
end

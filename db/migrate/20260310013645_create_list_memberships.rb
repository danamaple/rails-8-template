class CreateListMemberships < ActiveRecord::Migration[8.0]
  def change
    create_table :list_memberships do |t|
      t.integer :company_id
      t.integer :list_id

      t.timestamps
    end
  end
end

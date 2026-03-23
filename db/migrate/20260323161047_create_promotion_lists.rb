class CreatePromotionLists < ActiveRecord::Migration[8.0]
  def change
    create_table :promotion_lists do |t|
      t.integer :promotion_id
      t.integer :list_id

      t.timestamps
    end
  end
end

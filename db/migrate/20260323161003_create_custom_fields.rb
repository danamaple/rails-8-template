class CreateCustomFields < ActiveRecord::Migration[8.0]
  def change
    create_table :custom_fields do |t|
      t.string :field_name
      t.string :data_type

      t.timestamps
    end
  end
end

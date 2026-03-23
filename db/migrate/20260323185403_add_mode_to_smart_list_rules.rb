class AddModeToSmartListRules < ActiveRecord::Migration[8.0]
  def change
    add_column :smart_list_rules, :mode, :string
  end
end

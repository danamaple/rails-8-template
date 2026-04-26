class AddShowPricesToEmailTemplates < ActiveRecord::Migration[8.0]
  def change
    add_column :email_templates, :show_prices, :boolean
  end
end

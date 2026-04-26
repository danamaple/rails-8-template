Rails.application.routes.draw do
  # Routes for the Email product rule resource:

  # CREATE
  post("/insert_email_product_rule", { :controller => "email_product_rules", :action => "create" })

  # READ
  get("/email_product_rules", { :controller => "email_product_rules", :action => "index" })

  get("/email_product_rules/:path_id", { :controller => "email_product_rules", :action => "show" })

  # UPDATE

  post("/modify_email_product_rule/:path_id", { :controller => "email_product_rules", :action => "update" })

  # DELETE
  get("/delete_email_product_rule/:path_id", { :controller => "email_product_rules", :action => "destroy" })

  #------------------------------

  # Routes for the Email template product resource:

  # CREATE
  post("/insert_email_template_product", { :controller => "email_template_products", :action => "create" })

  # READ
  get("/email_template_products", { :controller => "email_template_products", :action => "index" })

  get("/email_template_products/:path_id", { :controller => "email_template_products", :action => "show" })

  # UPDATE

  post("/modify_email_template_product/:path_id", { :controller => "email_template_products", :action => "update" })

  # DELETE
  get("/delete_email_template_product/:path_id", { :controller => "email_template_products", :action => "destroy" })

  #------------------------------

  # Routes for the List exclusion resource:

  # CREATE
  post("/insert_list_exclusion", { :controller => "list_exclusions", :action => "create" })

  # READ
  get("/list_exclusions", { :controller => "list_exclusions", :action => "index" })

  get("/list_exclusions/:path_id", { :controller => "list_exclusions", :action => "show" })

  # UPDATE

  post("/modify_list_exclusion/:path_id", { :controller => "list_exclusions", :action => "update" })

  # DELETE
  get("/delete_list_exclusion/:path_id", { :controller => "list_exclusions", :action => "destroy" })

  #------------------------------

  # Routes for the Inventory removal resource:

  # CREATE
  post("/insert_inventory_removal", { :controller => "inventory_removals", :action => "create" })

  # READ
  get("/inventory_removals", { :controller => "inventory_removals", :action => "index" })

  get("/inventory_removals/:path_id", { :controller => "inventory_removals", :action => "show" })

  # UPDATE

  post("/modify_inventory_removal/:path_id", { :controller => "inventory_removals", :action => "update" })

  # DELETE
  get("/delete_inventory_removal/:path_id", { :controller => "inventory_removals", :action => "destroy" })

  #------------------------------

  # Routes for the Lot resource:

  # CREATE
  post("/insert_lot", { :controller => "lots", :action => "create" })

  # READ
  get("/lots", { :controller => "lots", :action => "index" })

  get("/lots/:path_id", { :controller => "lots", :action => "show" })

  # UPDATE

  post("/modify_lot/:path_id", { :controller => "lots", :action => "update" })

  # DELETE
  get("/delete_lot/:path_id", { :controller => "lots", :action => "destroy" })

  #------------------------------

  # Inventory overview routes
  get("/inventory",                           { :controller => "inventory", :action => "overview" })
  get("/inventory/locations",                 { :controller => "inventory", :action => "locations" })
  get("/inventory/locations/:path_id",        { :controller => "inventory", :action => "location_detail" })

  # Transfer lot
  post("/transfer_lot",                       { :controller => "lots", :action => "transfer" })

  #------------------------------

  # Routes for the Location resource:

  # CREATE
  get("/locations/new",                       { :controller => "locations", :action => "new" })
  post("/insert_location",                    { :controller => "locations", :action => "create" })

  # READ
  get("/locations",                           { :controller => "locations", :action => "index" })
  get("/locations/:path_id",                  { :controller => "locations", :action => "show" })

  # UPDATE
  post("/modify_location/:path_id",           { :controller => "locations", :action => "update" })

  # DELETE
  get("/delete_location/:path_id",            { :controller => "locations", :action => "destroy" })

  #------------------------------

  # Routes for the Promotion list resource:

  # CREATE
  post("/insert_promotion_list", { :controller => "promotion_lists", :action => "create" })

  # READ
  get("/promotion_lists", { :controller => "promotion_lists", :action => "index" })

  get("/promotion_lists/:path_id", { :controller => "promotion_lists", :action => "show" })

  # UPDATE

  post("/modify_promotion_list/:path_id", { :controller => "promotion_lists", :action => "update" })

  # DELETE
  get("/delete_promotion_list/:path_id", { :controller => "promotion_lists", :action => "destroy" })

  #------------------------------

  # Routes for the Promotion product resource:

  # CREATE
  post("/insert_promotion_product", { :controller => "promotion_products", :action => "create" })

  # READ
  get("/promotion_products", { :controller => "promotion_products", :action => "index" })

  get("/promotion_products/:path_id", { :controller => "promotion_products", :action => "show" })

  # UPDATE

  post("/modify_promotion_product/:path_id", { :controller => "promotion_products", :action => "update" })

  # DELETE
  get("/delete_promotion_product/:path_id", { :controller => "promotion_products", :action => "destroy" })

  #------------------------------

  # Routes for the Promotion resource:

  # CREATE
  post("/insert_promotion", { :controller => "promotions", :action => "create" })

  # READ
  get("/promotions", { :controller => "promotions", :action => "index" })
  get("/promotions/new", { :controller => "promotions", :action => "new" })
  get("/promotions/:path_id", { :controller => "promotions", :action => "show" })

  # UPDATE

  post("/modify_promotion/:path_id", { :controller => "promotions", :action => "update" })

  # DELETE
  get("/delete_promotion/:path_id", { :controller => "promotions", :action => "destroy" })

  #------------------------------

  # Routes for the Customer price resource:

  # CREATE
  post("/insert_customer_price", { :controller => "customer_prices", :action => "create" })

  # READ
  get("/customer_prices", { :controller => "customer_prices", :action => "index" })

  get("/customer_prices/:path_id", { :controller => "customer_prices", :action => "show" })

  # UPDATE

  post("/modify_customer_price/:path_id", { :controller => "customer_prices", :action => "update" })

  # DELETE
  get("/delete_customer_price/:path_id", { :controller => "customer_prices", :action => "destroy" })

  #------------------------------

  # Routes for the Product price resource:

  # CREATE
  post("/insert_product_price", { :controller => "product_prices", :action => "create" })

  # READ
  get("/product_prices", { :controller => "product_prices", :action => "index" })

  get("/product_prices/:path_id", { :controller => "product_prices", :action => "show" })

  # UPDATE
  post("/modify_product_price/:path_id", { :controller => "product_prices", :action => "update" })
  post("/split_product_prices/:path_id", { :controller => "product_prices", :action => "split" })

  # DELETE
  get("/delete_product_price/:path_id", { :controller => "product_prices", :action => "destroy" })

  #------------------------------

  # Routes for the Price category resource:

  # CREATE
  post("/insert_price_category", { :controller => "price_categories", :action => "create" })

  # READ
  get("/price_categories", { :controller => "price_categories", :action => "index" })

  get("/price_categories/:path_id", { :controller => "price_categories", :action => "show" })

  # UPDATE

  post("/modify_price_category/:path_id", { :controller => "price_categories", :action => "update" })

  # DELETE
  get("/delete_price_category/:path_id", { :controller => "price_categories", :action => "destroy" })

  #------------------------------

  # Routes for the Custom field value resource:

  # CREATE
  post("/insert_custom_field_value", { :controller => "custom_field_values", :action => "create" })

  # READ
  get("/custom_field_values", { :controller => "custom_field_values", :action => "index" })

  get("/custom_field_values/:path_id", { :controller => "custom_field_values", :action => "show" })

  # UPDATE

  post("/modify_custom_field_value/:path_id", { :controller => "custom_field_values", :action => "update" })

  # DELETE
  get("/delete_custom_field_value/:path_id", { :controller => "custom_field_values", :action => "destroy" })

  #------------------------------

  # Routes for the Custom field resource:

  # CREATE
  post("/insert_custom_field", { :controller => "custom_fields", :action => "create" })

  # READ
  get("/custom_fields", { :controller => "custom_fields", :action => "index" })

  get("/custom_fields/:path_id", { :controller => "custom_fields", :action => "show" })

  # UPDATE

  post("/modify_custom_field/:path_id", { :controller => "custom_fields", :action => "update" })

  # DELETE
  get("/delete_custom_field/:path_id", { :controller => "custom_fields", :action => "destroy" })

  #------------------------------

  # Routes for the Product resource:

  # CREATE
  post("/insert_product", { :controller => "products", :action => "create" })

  # READ
  get("/products", { :controller => "products", :action => "index" })
  get("/products/new", { :controller => "products", :action => "new" })
  get("/products/:path_id", { :controller => "products", :action => "show" })

  # UPDATE
  post("/modify_product/:path_id", { :controller => "products", :action => "update" })

  # DELETE
  get("/delete_product/:path_id", { :controller => "products", :action => "destroy" })

  # EXPORT
  get("/export_products", { :controller => "products", :action => "export" })

  #------------------------------

  # Routes for unified Product Categories controller:
  get("/product_categories", { :controller => "product_categories", :action => "index" })
  post("/insert_product_category_one", { :controller => "product_categories", :action => "create_one" })
  post("/insert_product_category_two", { :controller => "product_categories", :action => "create_two" })
  post("/insert_product_category_three", { :controller => "product_categories", :action => "create_three" })

  #------------------------------

  # Routes for the Product category three resource:

  # CREATE
  post("/insert_product_category_three", { :controller => "product_category_threes", :action => "create" })

  # READ
  get("/product_category_threes", { :controller => "product_category_threes", :action => "index" })

  get("/product_category_threes/:path_id", { :controller => "product_category_threes", :action => "show" })

  # UPDATE

  post("/modify_product_category_three/:path_id", { :controller => "product_category_threes", :action => "update" })

  # DELETE
  get("/delete_product_category_three/:path_id", { :controller => "product_category_threes", :action => "destroy" })

  #------------------------------

  # Routes for the Product category two resource:

  # CREATE
  post("/insert_product_category_two", { :controller => "product_category_twos", :action => "create" })

  # READ
  get("/product_category_twos", { :controller => "product_category_twos", :action => "index" })

  get("/product_category_twos/:path_id", { :controller => "product_category_twos", :action => "show" })

  # UPDATE

  post("/modify_product_category_two/:path_id", { :controller => "product_category_twos", :action => "update" })

  # DELETE
  get("/delete_product_category_two/:path_id", { :controller => "product_category_twos", :action => "destroy" })

  #------------------------------

  # Routes for the Product category one resource:

  # CREATE
  post("/insert_product_category_one", { :controller => "product_category_ones", :action => "create" })

  # READ
  get("/product_category_ones", { :controller => "product_category_ones", :action => "index" })

  get("/product_category_ones/:path_id", { :controller => "product_category_ones", :action => "show" })

  # UPDATE

  post("/modify_product_category_one/:path_id", { :controller => "product_category_ones", :action => "update" })

  # DELETE
  get("/delete_product_category_one/:path_id", { :controller => "product_category_ones", :action => "destroy" })

  #------------------------------

  # Routes for the Supplier resource:

  # CREATE
  post("/insert_supplier", { :controller => "suppliers", :action => "create" })

  # READ
  get("/suppliers", { :controller => "suppliers", :action => "index" })

  get("/suppliers/:path_id", { :controller => "suppliers", :action => "show" })

  # UPDATE

  post("/modify_supplier/:path_id", { :controller => "suppliers", :action => "update" })

  # DELETE
  get("/delete_supplier/:path_id", { :controller => "suppliers", :action => "destroy" })

  #------------------------------

  # Routes for the Brand resource:

  # CREATE
  post("/insert_brand", { :controller => "brands", :action => "create" })

  # READ
  get("/brands", { :controller => "brands", :action => "index" })

  get("/brands/:path_id", { :controller => "brands", :action => "show" })

  # UPDATE

  post("/modify_brand/:path_id", { :controller => "brands", :action => "update" })

  # DELETE
  get("/delete_brand/:path_id", { :controller => "brands", :action => "destroy" })

  #------------------------------

  # Routes for the Email send resource:

  # CREATE
  post("/insert_email_send", { :controller => "email_sends", :action => "create" })

  # READ
  get("/email_sends", { :controller => "email_sends", :action => "index" })

  get("/email_sends/:path_id", { :controller => "email_sends", :action => "show" })

  # UPDATE

  post("/modify_email_send/:path_id", { :controller => "email_sends", :action => "update" })

  # DELETE
  get("/delete_email_send/:path_id", { :controller => "email_sends", :action => "destroy" })

  # EXPORT
  get("/export_email_sends", { :controller => "email_sends", :action => "export" })

  # UNSUBSCRIBE (no auth required)
  get("/unsubscribe/:path_id", { :controller => "emails", :action => "unsubscribe" })

  #------------------------------

  # Routes for the Email template resource:

  # CREATE
  post("/insert_email_template", { :controller => "email_templates", :action => "create" })

  # READ
  get("/email_templates", { :controller => "email_templates", :action => "index" })

  get("/email_templates/new", { :controller => "email_templates", :action => "new" })

  get("/email_templates/:path_id", { :controller => "email_templates", :action => "show" })

  # UPDATE
  post("/modify_email_template/:path_id", { :controller => "email_templates", :action => "update" })

  # DELETE
  get("/delete_email_template/:path_id", { :controller => "email_templates", :action => "destroy" })

  # EXPORT
  get("/export_email_templates", { :controller => "email_templates", :action => "export" })

  # SENDING
  post("/send_email",      { :controller => "emails", :action => "send_single" })
  post("/send_bulk_email", { :controller => "emails", :action => "send_bulk" })

  #------------------------------

  # Routes for the Smart list rule resource:

  # CREATE
  post("/insert_smart_list_rule", { :controller => "smart_list_rules", :action => "create" })

  # READ
  get("/smart_list_rules", { :controller => "smart_list_rules", :action => "index" })

  get("/smart_list_rules/:path_id", { :controller => "smart_list_rules", :action => "show" })

  # UPDATE

  post("/modify_smart_list_rule/:path_id", { :controller => "smart_list_rules", :action => "update" })

  # DELETE
  get("/delete_smart_list_rule/:path_id", { :controller => "smart_list_rules", :action => "destroy" })

  #------------------------------

  # Admin routes
  get("/admin/import",  { :controller => "admin", :action => "import" })
  post("/admin/import", { :controller => "admin", :action => "do_import" })
  get("/admin/template", { :controller => "admin", :action => "template" })
  post("/admin/purge",  { :controller => "admin", :action => "purge" })

  #------------------------------

  # Routes for the List membership resource:

  # CREATE
  post("/insert_list_membership", { :controller => "list_memberships", :action => "create" })
  post("/toggle_list_member",     { :controller => "list_memberships", :action => "toggle" })

  # DELETE
  get("/delete_list_membership/:path_id", { :controller => "list_memberships", :action => "destroy" })

  #------------------------------

  # Routes for the List resource:

  # CREATE
  post("/insert_list", { :controller => "lists", :action => "create" })

  # READ
  get("/lists", { :controller => "lists", :action => "index" })

  get("/lists/new", { :controller => "lists", :action => "new" })

  get("/lists/:path_id", { :controller => "lists", :action => "show" })

  # UPDATE

  post("/modify_list/:path_id", { :controller => "lists", :action => "update" })

  # DELETE
  get("/delete_list/:path_id", { :controller => "lists", :action => "destroy" })

  # EXPORT
  get("/export_lists", { :controller => "lists", :action => "export" })
  get("/export_list_members/:path_id", { :controller => "lists", :action => "export_members" })

  #------------------------------

  devise_for :users
  # Routes for the Outreach resource:

  # CREATE
  post("/insert_outreach", { :controller => "outreaches", :action => "create" })

  # READ
  get("/outreaches", { :controller => "outreaches", :action => "index" })

  get("/outreaches/new", { :controller => "outreaches", :action => "new" })

  get("/outreaches/:path_id", { :controller => "outreaches", :action => "show" })

  # UPDATE

  post("/modify_outreach/:path_id", { :controller => "outreaches", :action => "update" })

  # DELETE
  get("/delete_outreach/:path_id", { :controller => "outreaches", :action => "destroy" })

  # EXPORT
  get("/export_outreach", { :controller => "outreaches", :action => "export" })

  #------------------------------

  # Routes for the Portfolio resource:

  # CREATE
  post("/insert_portfolio", { :controller => "portfolios", :action => "create" })

  # READ
  get("/portfolios", { :controller => "portfolios", :action => "index" })

  get("/portfolios/:path_id", { :controller => "portfolios", :action => "show" })

  # UPDATE

  post("/modify_portfolio/:path_id", { :controller => "portfolios", :action => "update" })

  # DELETE
  get("/delete_portfolio/:path_id", { :controller => "portfolios", :action => "destroy" })

  #------------------------------

  # Routes for the Category resource:

  # CREATE
  post("/insert_category", { :controller => "categories", :action => "create" })

  # READ
  get("/categories", { :controller => "categories", :action => "index" })

  get("/categories/:path_id", { :controller => "categories", :action => "show" })

  # UPDATE

  post("/modify_category/:path_id", { :controller => "categories", :action => "update" })

  # DELETE
  get("/delete_category/:path_id", { :controller => "categories", :action => "destroy" })

  # EXPORT
  get("/export_categories", { :controller => "categories", :action => "export" })

  #------------------------------

  # Routes for the Company resource:

  # CREATE
  post("/insert_company", { :controller => "companies", :action => "create" })

  # READ
  get("/companies", { :controller => "companies", :action => "index" })

  get("/companies/new", { :controller => "companies", :action => "new" })

  get("/companies/:path_id", { :controller => "companies", :action => "show" })

  # UPDATE

  post("/modify_company/:path_id", { :controller => "companies", :action => "update" })

  # DELETE
  get("/delete_company/:path_id", { :controller => "companies", :action => "destroy" })

  # EXPORT
  get("/export_companies", { :controller => "companies", :action => "export" })

  #------------------------------

  # Routes for the Contact resource:

  # CREATE
  post("/insert_contact", { :controller => "contacts", :action => "create" })

  # READ
  get("/contacts", { :controller => "contacts", :action => "index" })

  get("/contacts/new", { :controller => "contacts", :action => "new" })

  get("/contacts/:path_id", { :controller => "contacts", :action => "show" })

  # UPDATE

  post("/modify_contact/:path_id", { :controller => "contacts", :action => "update" })

  # DELETE
  get("/delete_contact/:path_id", { :controller => "contacts", :action => "destroy" })

  # EXPORT
  get("/export_contacts", { :controller => "contacts", :action => "export" })

  #------------------------------

  root({ :controller => "companies", :action => "index" })
end

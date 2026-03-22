Rails.application.routes.draw do
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

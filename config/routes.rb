Rails.application.routes.draw do
  devise_for :users
  # Routes for the Outreach resource:

  # CREATE
  post("/insert_outreach", { :controller => "outreaches", :action => "create" })

  # READ
  get("/outreaches", { :controller => "outreaches", :action => "index" })

  get("/outreaches/:path_id", { :controller => "outreaches", :action => "show" })

  # UPDATE

  post("/modify_outreach/:path_id", { :controller => "outreaches", :action => "update" })

  # DELETE
  get("/delete_outreach/:path_id", { :controller => "outreaches", :action => "destroy" })

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

  #------------------------------

  root({ :controller => "companies", :action => "index" })
end

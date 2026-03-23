class SuppliersController < ApplicationController
  def index
    matching_suppliers = Supplier.all

    @list_of_suppliers = matching_suppliers.order({ :created_at => :desc })

    render({ :template => "supplier_templates/index" })
  end

  def show
    the_id = params.fetch("path_id")

    matching_suppliers = Supplier.where({ :id => the_id })

    @the_supplier = matching_suppliers.at(0)

    render({ :template => "supplier_templates/show" })
  end

  def create
    the_supplier = Supplier.new
    the_supplier.name = params.fetch("query_name")
    the_supplier.contact_name = params.fetch("query_contact_name")
    the_supplier.email = params.fetch("query_email")
    the_supplier.phone = params.fetch("query_phone")
    the_supplier.website = params.fetch("query_website")

    if the_supplier.valid?
      the_supplier.save
      redirect_to("/suppliers", { :notice => "Supplier created successfully." })
    else
      redirect_to("/suppliers", { :alert => the_supplier.errors.full_messages.to_sentence })
    end
  end

  def update
    the_id = params.fetch("path_id")
    the_supplier = Supplier.where({ :id => the_id }).at(0)

    the_supplier.name = params.fetch("query_name")
    the_supplier.contact_name = params.fetch("query_contact_name")
    the_supplier.email = params.fetch("query_email")
    the_supplier.phone = params.fetch("query_phone")
    the_supplier.website = params.fetch("query_website")

    if the_supplier.valid?
      the_supplier.save
      redirect_to("/suppliers/#{the_supplier.id}", { :notice => "Supplier updated successfully." } )
    else
      redirect_to("/suppliers/#{the_supplier.id}", { :alert => the_supplier.errors.full_messages.to_sentence })
    end
  end

  def destroy
    the_id = params.fetch("path_id")
    the_supplier = Supplier.where({ :id => the_id }).at(0)

    the_supplier.destroy

    redirect_to("/suppliers", { :notice => "Supplier deleted successfully." } )
  end
end

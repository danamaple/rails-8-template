class LocationsController < ApplicationController
  def index
    @list_of_locations = Location.all.order({ :created_at => :desc })
    render({ :template => "location_templates/index" })
  end

  def new
    @companies = Company.order(:company_name)
    render({ :template => "location_templates/new" })
  end

  def show
    the_id = params.fetch("path_id")
    @the_location = Location.where({ :id => the_id }).at(0)
    render({ :template => "location_templates/show" })
  end

  def create
    the_location = Location.new
    the_location.name          = params.fetch("query_name", "")
    the_location.location_type = params.fetch("query_location_type", "warehouse")
    the_location.company_id    = params.fetch("query_company_id", nil).presence

    if the_location.valid?
      the_location.save
      redirect_to("/inventory/locations", { :notice => "Location created successfully." })
    else
      redirect_to("/locations/new", { :alert => the_location.errors.full_messages.to_sentence })
    end
  end

  def update
    the_id = params.fetch("path_id")
    the_location = Location.where({ :id => the_id }).at(0)

    the_location.name          = params.fetch("query_name", "")
    the_location.location_type = params.fetch("query_location_type", "warehouse")
    the_location.company_id    = params.fetch("query_company_id", nil).presence

    if the_location.valid?
      the_location.save
      redirect_to("/inventory/locations/#{the_location.id}", { :notice => "Location updated successfully." })
    else
      redirect_to("/inventory/locations/#{the_location.id}", { :alert => the_location.errors.full_messages.to_sentence })
    end
  end

  def destroy
    the_id = params.fetch("path_id")
    the_location = Location.where({ :id => the_id }).at(0)
    the_location.destroy
    redirect_to("/inventory/locations", { :notice => "Location deleted successfully." })
  end
end

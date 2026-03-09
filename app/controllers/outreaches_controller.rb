class OutreachesController < ApplicationController
  def index
    matching_outreaches = Outreach.all

    if params["query_outreach_medium"].present?
      matching_outreaches = matching_outreaches.where({ :outreach_medium => params["query_outreach_medium"] })
    end

    if params["query_rep_id"].present?
      matching_outreaches = matching_outreaches.where({ :rep_id => params["query_rep_id"] })
    end

    if params["query_start_date"].present?
      matching_outreaches = matching_outreaches.where("outreach_datetime >= ?", params["query_start_date"])
    end

    if params["query_end_date"].present?
      matching_outreaches = matching_outreaches.where("outreach_datetime <= ?", params["query_end_date"] + " 23:59:59")
    end

    @total_count = Outreach.count
    @filtered_count = matching_outreaches.count
    @list_of_outreaches = matching_outreaches.order({ :outreach_datetime => :desc })
    @mediums = Outreach.distinct.pluck(:outreach_medium).compact.reject { |m| m.blank? }.sort
    @list_of_reps = User.all.order({ :last_name => :asc })

    render({ :template => "outreach_templates/index" })
  end

  def show
    the_id = params.fetch("path_id")

    matching_outreaches = Outreach.where({ :id => the_id })

    @the_outreach = matching_outreaches.at(0)

    render({ :template => "outreach_templates/show" })
  end

  def create
    the_outreach = Outreach.new
    the_outreach.contact_id = params.fetch("query_contact_id")
    the_outreach.outreach_datetime = params.fetch("query_outreach_datetime")
    the_outreach.outreach_medium = params.fetch("query_outreach_medium")
    the_outreach.rep_id = current_user.id
    the_outreach.notes = params.fetch("query_notes", "")

    if the_outreach.valid?
      the_outreach.save
      redirect_to("/contacts/#{the_outreach.contact_id}", { :notice => "Outreach logged successfully." })
    else
      redirect_to("/contacts/#{the_outreach.contact_id}", { :alert => the_outreach.errors.full_messages.to_sentence })
    end
  end

  def update
    the_id = params.fetch("path_id")
    the_outreach = Outreach.where({ :id => the_id }).at(0)

    the_outreach.contact_id = params.fetch("query_contact_id")
    the_outreach.outreach_datetime = params.fetch("query_outreach_datetime")
    the_outreach.outreach_medium = params.fetch("query_outreach_medium")
    the_outreach.notes = params.fetch("query_notes", "")

    if the_outreach.valid?
      the_outreach.save
      redirect_to("/outreaches/#{the_outreach.id}", { :notice => "Outreach updated successfully." })
    else
      redirect_to("/outreaches/#{the_outreach.id}", { :alert => the_outreach.errors.full_messages.to_sentence })
    end
  end

  def destroy
    the_id = params.fetch("path_id")
    the_outreach = Outreach.where({ :id => the_id }).at(0)
    the_contact_id = the_outreach.contact_id

    the_outreach.destroy

    redirect_to("/contacts/#{the_contact_id}", { :notice => "Outreach deleted successfully." })
  end
end

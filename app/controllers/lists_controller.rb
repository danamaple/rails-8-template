class ListsController < ApplicationController
  def index
    matching_lists = List.all

    if params["query_name"].present?
      matching_lists = matching_lists.where("name ILIKE ?", "%#{params["query_name"]}%")
    end

    @list_of_lists = matching_lists.order({ :name => :asc })

    render({ :template => "list_templates/index" })
  end

  def new
    render({ :template => "list_templates/new" })
  end

  def show
    the_id = params.fetch("path_id")
    @the_list = List.where({ :id => the_id }).at(0)
    @list_of_all_companies = Company.all.order({ :company_name => :asc })
    @list_of_email_templates = EmailTemplate.all.order({ :name => :asc })
    @all_members = @the_list.all_companies.order({ :company_name => :asc })
    @excluded_companies = Company.where(:id => @the_list.list_exclusions.pluck(:company_id)).order({ :company_name => :asc })
    @manual_ids = @the_list.list_memberships.pluck(:company_id)
    @rule_matched_ids = @the_list.smart_list_rules.any? ? List.evaluate_rules(@the_list.smart_list_rules).pluck(:id) : []

    render({ :template => "list_templates/show" })
  end

  def create
    the_list = List.new
    the_list.name = params.fetch("query_name")
    the_list.notes = params.fetch("query_notes", "")

    if the_list.valid?
      the_list.save
      redirect_to("/lists/#{the_list.id}", { :notice => "List created successfully." })
    else
      redirect_to("/lists", { :alert => the_list.errors.full_messages.to_sentence })
    end
  end

  def update
    the_id = params.fetch("path_id")
    the_list = List.where({ :id => the_id }).at(0)

    the_list.name = params.fetch("query_name")
    the_list.notes = params.fetch("query_notes", "")

    if the_list.valid?
      the_list.save
      redirect_to("/lists/#{the_list.id}", { :notice => "List updated successfully." })
    else
      redirect_to("/lists/#{the_list.id}", { :alert => the_list.errors.full_messages.to_sentence })
    end
  end

  def destroy
    the_id = params.fetch("path_id")
    the_list = List.where({ :id => the_id }).at(0)

    the_list.destroy

    redirect_to("/lists", { :notice => "List deleted successfully." })
  end

  def export
    matching_lists = List.all

    if params["query_name"].present?
      matching_lists = matching_lists.where("name ILIKE ?", "%#{params["query_name"]}%")
    end

    matching_lists = matching_lists.order({ :name => :asc })

    respond_to do |format|
      format.csv do
        send_data(List.to_csv(matching_lists), { :filename => "lists-#{Date.today}.csv" })
      end
    end
  end

  def export_members
    the_id = params.fetch("path_id")
    the_list = List.where({ :id => the_id }).at(0)
    members = the_list.all_companies.order({ :company_name => :asc })

    respond_to do |format|
      format.csv do
        send_data(Company.to_csv(members), { :filename => "list-members-#{the_list.name}-#{Date.today}.csv" })
      end
    end
  end
end

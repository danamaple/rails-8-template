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
    matching_lists = List.where({ :id => the_id })
    @the_list = matching_lists.at(0)
    @list_of_all_companies = Company.all.order({ :company_name => :asc })

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
end

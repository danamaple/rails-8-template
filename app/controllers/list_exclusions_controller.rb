class ListExclusionsController < ApplicationController
  def index
    matching_list_exclusions = ListExclusion.all

    @list_of_list_exclusions = matching_list_exclusions.order({ :created_at => :desc })

    render({ :template => "list_exclusion_templates/index" })
  end

  def show
    the_id = params.fetch("path_id")

    matching_list_exclusions = ListExclusion.where({ :id => the_id })

    @the_list_exclusion = matching_list_exclusions.at(0)

    render({ :template => "list_exclusion_templates/show" })
  end

  def create
    the_list_exclusion = ListExclusion.new
    the_list_exclusion.list_id = params.fetch("query_list_id")
    the_list_exclusion.company_id = params.fetch("query_company_id")

    if the_list_exclusion.valid?
      the_list_exclusion.save
      redirect_to("/list_exclusions", { :notice => "List exclusion created successfully." })
    else
      redirect_to("/list_exclusions", { :alert => the_list_exclusion.errors.full_messages.to_sentence })
    end
  end

  def update
    the_id = params.fetch("path_id")
    the_list_exclusion = ListExclusion.where({ :id => the_id }).at(0)

    the_list_exclusion.list_id = params.fetch("query_list_id")
    the_list_exclusion.company_id = params.fetch("query_company_id")

    if the_list_exclusion.valid?
      the_list_exclusion.save
      redirect_to("/list_exclusions/#{the_list_exclusion.id}", { :notice => "List exclusion updated successfully." } )
    else
      redirect_to("/list_exclusions/#{the_list_exclusion.id}", { :alert => the_list_exclusion.errors.full_messages.to_sentence })
    end
  end

  def destroy
    the_id = params.fetch("path_id")
    the_list_exclusion = ListExclusion.where({ :id => the_id }).at(0)

    the_list_exclusion.destroy

    redirect_to("/list_exclusions", { :notice => "List exclusion deleted successfully." } )
  end
end

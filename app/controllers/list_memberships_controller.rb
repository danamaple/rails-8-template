class ListMembershipsController < ApplicationController
  def create
    the_list_membership = ListMembership.new
    the_list_membership.company_id = params.fetch("query_company_id")
    the_list_membership.list_id = params.fetch("query_list_id")

    if the_list_membership.valid?
      the_list_membership.save
      if params["query_source"] == "company"
        redirect_to("/companies/#{the_list_membership.company_id}", { :notice => "List assigned successfully." })
      else
        redirect_to("/lists/#{the_list_membership.list_id}", { :notice => "Company added to list successfully." })
      end
    else
      if params["query_source"] == "company"
        redirect_to("/companies/#{params["query_company_id"]}", { :alert => the_list_membership.errors.full_messages.to_sentence })
      else
        redirect_to("/lists/#{params["query_list_id"]}", { :alert => the_list_membership.errors.full_messages.to_sentence })
      end
    end
  end

  def toggle
    the_list_id    = params.fetch("query_list_id")
    the_company_id = params.fetch("query_company_id")
    checked        = params.fetch("query_checked")

    if checked == "false"
      ListExclusion.find_or_create_by(:list_id => the_list_id, :company_id => the_company_id)
      membership = ListMembership.where(:list_id => the_list_id, :company_id => the_company_id).at(0)
      membership.destroy if membership.present?
    else
      exclusion = ListExclusion.where(:list_id => the_list_id, :company_id => the_company_id).at(0)
      exclusion.destroy if exclusion.present?
    end

    redirect_to("/lists/#{the_list_id}", { :notice => "List updated." })
  end

  def destroy
    the_id = params.fetch("path_id")
    the_list_membership = ListMembership.where({ :id => the_id }).at(0)
    the_list_id = the_list_membership.list_id
    the_company_id = the_list_membership.company_id

    the_list_membership.destroy

    if params["source"] == "company"
      redirect_to("/companies/#{the_company_id}", { :notice => "List removed successfully." })
    else
      redirect_to("/lists/#{the_list_id}", { :notice => "Company removed from list successfully." })
    end
  end
end

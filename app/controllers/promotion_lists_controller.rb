class PromotionListsController < ApplicationController
  def index
    matching_promotion_lists = PromotionList.all

    @list_of_promotion_lists = matching_promotion_lists.order({ :created_at => :desc })

    render({ :template => "promotion_list_templates/index" })
  end

  def show
    the_id = params.fetch("path_id")

    matching_promotion_lists = PromotionList.where({ :id => the_id })

    @the_promotion_list = matching_promotion_lists.at(0)

    render({ :template => "promotion_list_templates/show" })
  end

  def create
    the_promotion_list = PromotionList.new
    the_promotion_list.promotion_id = params.fetch("query_promotion_id")
    the_promotion_list.list_id = params.fetch("query_list_id")

    if the_promotion_list.valid?
      the_promotion_list.save
      redirect_to("/promotions/#{the_promotion_list.promotion_id}", { :notice => "List added to promotion." })
    else
      redirect_to("/promotions/#{the_promotion_list.promotion_id}", { :alert => the_promotion_list.errors.full_messages.to_sentence })
    end
  end

  def update
    the_id = params.fetch("path_id")
    the_promotion_list = PromotionList.where({ :id => the_id }).at(0)

    the_promotion_list.promotion_id = params.fetch("query_promotion_id")
    the_promotion_list.list_id = params.fetch("query_list_id")

    if the_promotion_list.valid?
      the_promotion_list.save
      redirect_to("/promotion_lists/#{the_promotion_list.id}", { :notice => "Promotion list updated successfully." } )
    else
      redirect_to("/promotion_lists/#{the_promotion_list.id}", { :alert => the_promotion_list.errors.full_messages.to_sentence })
    end
  end

  def destroy
    the_id = params.fetch("path_id")
    the_promotion_list = PromotionList.where({ :id => the_id }).at(0)

    promotion_id = the_promotion_list.promotion_id
    the_promotion_list.destroy
    redirect_to("/promotions/#{promotion_id}", { :notice => "List removed from promotion." })
  end
end

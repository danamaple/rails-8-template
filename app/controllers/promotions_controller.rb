class PromotionsController < ApplicationController
  def index
    @list_of_promotions = Promotion.all.order({ :created_at => :desc })
    render({ :template => "promotion_templates/index" })
  end

  def new
    render({ :template => "promotion_templates/new" })
  end

  def show
    the_id = params.fetch("path_id")
    @the_promotion = Promotion.where({ :id => the_id }).at(0)
    @products_available = Product.order(:name)
    @lists_available = List.order(:name)
    render({ :template => "promotion_templates/show" })
  end

  def create
    the_promotion = Promotion.new
    the_promotion.name = params.fetch("query_name", "")
    the_promotion.start_date = params.fetch("query_start_date", nil).presence
    the_promotion.end_date = params.fetch("query_end_date", nil).presence
    the_promotion.buy_quantity = params.fetch("query_buy_quantity", nil).presence
    the_promotion.get_quantity = params.fetch("query_get_quantity", nil).presence
    the_promotion.discount_percent = params.fetch("query_discount_percent", nil).presence
    the_promotion.discount_type = params.fetch("query_discount_type", "")
    the_promotion.discount_value = params.fetch("query_discount_value", nil).presence
    the_promotion.min_quantity = params.fetch("query_min_quantity", nil).presence
    the_promotion.description = params.fetch("query_description", "")

    if the_promotion.valid?
      the_promotion.save
      redirect_to("/promotions/#{the_promotion.id}", { :notice => "Promotion created successfully." })
    else
      redirect_to("/promotions/new", { :alert => the_promotion.errors.full_messages.to_sentence })
    end
  end

  def update
    the_id = params.fetch("path_id")
    the_promotion = Promotion.where({ :id => the_id }).at(0)

    the_promotion.name = params.fetch("query_name", "")
    the_promotion.start_date = params.fetch("query_start_date", nil).presence
    the_promotion.end_date = params.fetch("query_end_date", nil).presence
    the_promotion.buy_quantity = params.fetch("query_buy_quantity", nil).presence
    the_promotion.get_quantity = params.fetch("query_get_quantity", nil).presence
    the_promotion.discount_percent = params.fetch("query_discount_percent", nil).presence
    the_promotion.discount_type = params.fetch("query_discount_type", "")
    the_promotion.discount_value = params.fetch("query_discount_value", nil).presence
    the_promotion.min_quantity = params.fetch("query_min_quantity", nil).presence
    the_promotion.description = params.fetch("query_description", "")

    if the_promotion.valid?
      the_promotion.save
      redirect_to("/promotions/#{the_promotion.id}", { :notice => "Promotion updated successfully." })
    else
      redirect_to("/promotions/#{the_promotion.id}", { :alert => the_promotion.errors.full_messages.to_sentence })
    end
  end

  def destroy
    the_id = params.fetch("path_id")
    the_promotion = Promotion.where({ :id => the_id }).at(0)
    the_promotion.destroy
    redirect_to("/promotions", { :notice => "Promotion deleted successfully." })
  end
end

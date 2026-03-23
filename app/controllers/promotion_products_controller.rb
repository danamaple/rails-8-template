class PromotionProductsController < ApplicationController
  def index
    matching_promotion_products = PromotionProduct.all

    @list_of_promotion_products = matching_promotion_products.order({ :created_at => :desc })

    render({ :template => "promotion_product_templates/index" })
  end

  def show
    the_id = params.fetch("path_id")

    matching_promotion_products = PromotionProduct.where({ :id => the_id })

    @the_promotion_product = matching_promotion_products.at(0)

    render({ :template => "promotion_product_templates/show" })
  end

  def create
    the_promotion_product = PromotionProduct.new
    the_promotion_product.promotion_id = params.fetch("query_promotion_id")
    the_promotion_product.product_id = params.fetch("query_product_id")

    if the_promotion_product.valid?
      the_promotion_product.save
      redirect_to("/promotions/#{the_promotion_product.promotion_id}", { :notice => "Product added to promotion." })
    else
      redirect_to("/promotions/#{the_promotion_product.promotion_id}", { :alert => the_promotion_product.errors.full_messages.to_sentence })
    end
  end

  def update
    the_id = params.fetch("path_id")
    the_promotion_product = PromotionProduct.where({ :id => the_id }).at(0)

    the_promotion_product.promotion_id = params.fetch("query_promotion_id")
    the_promotion_product.product_id = params.fetch("query_product_id")

    if the_promotion_product.valid?
      the_promotion_product.save
      redirect_to("/promotion_products/#{the_promotion_product.id}", { :notice => "Promotion product updated successfully." } )
    else
      redirect_to("/promotion_products/#{the_promotion_product.id}", { :alert => the_promotion_product.errors.full_messages.to_sentence })
    end
  end

  def destroy
    the_id = params.fetch("path_id")
    the_promotion_product = PromotionProduct.where({ :id => the_id }).at(0)

    promotion_id = the_promotion_product.promotion_id
    the_promotion_product.destroy
    redirect_to("/promotions/#{promotion_id}", { :notice => "Product removed from promotion." })
  end
end

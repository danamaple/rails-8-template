class PriceCategoriesController < ApplicationController
  def index
    matching_price_categories = PriceCategory.all

    @list_of_price_categories = matching_price_categories.order({ :created_at => :desc })

    render({ :template => "price_category_templates/index" })
  end

  def show
    the_id = params.fetch("path_id")

    matching_price_categories = PriceCategory.where({ :id => the_id })

    @the_price_category = matching_price_categories.at(0)

    render({ :template => "price_category_templates/show" })
  end

  def create
    the_price_category = PriceCategory.new
    the_price_category.name = params.fetch("query_name")

    if the_price_category.valid?
      the_price_category.save
      # Auto-create a ProductPrice row for every existing product
      Product.all.each do |product|
        pp = ProductPrice.new
        pp.product_id = product.id
        pp.price_category_id = the_price_category.id
        pp.min_quantity = 1
        pp.max_quantity = nil
        pp.unit_price = 0
        pp.save
      end
      redirect_to("/price_categories", { :notice => "Price category created successfully." })
    else
      redirect_to("/price_categories", { :alert => the_price_category.errors.full_messages.to_sentence })
    end
  end

  def update
    the_id = params.fetch("path_id")
    the_price_category = PriceCategory.where({ :id => the_id }).at(0)

    the_price_category.name = params.fetch("query_name")

    if the_price_category.valid?
      the_price_category.save
      redirect_to("/price_categories/#{the_price_category.id}", { :notice => "Price category updated successfully." } )
    else
      redirect_to("/price_categories/#{the_price_category.id}", { :alert => the_price_category.errors.full_messages.to_sentence })
    end
  end

  def destroy
    the_id = params.fetch("path_id")
    the_price_category = PriceCategory.where({ :id => the_id }).at(0)

    the_price_category.destroy

    redirect_to("/price_categories", { :notice => "Price category deleted successfully." } )
  end
end

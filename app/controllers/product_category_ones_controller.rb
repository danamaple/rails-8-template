class ProductCategoryOnesController < ApplicationController
  def index
    matching_product_category_ones = ProductCategoryOne.all

    @list_of_product_category_ones = matching_product_category_ones.order({ :created_at => :desc })

    render({ :template => "product_category_one_templates/index" })
  end

  def show
    the_id = params.fetch("path_id")

    matching_product_category_ones = ProductCategoryOne.where({ :id => the_id })

    @the_product_category_one = matching_product_category_ones.at(0)

    render({ :template => "product_category_one_templates/show" })
  end

  def create
    the_product_category_one = ProductCategoryOne.new
    the_product_category_one.name = params.fetch("query_name")

    if the_product_category_one.valid?
      the_product_category_one.save
      redirect_to("/product_category_ones", { :notice => "Product category one created successfully." })
    else
      redirect_to("/product_category_ones", { :alert => the_product_category_one.errors.full_messages.to_sentence })
    end
  end

  def update
    the_id = params.fetch("path_id")
    the_product_category_one = ProductCategoryOne.where({ :id => the_id }).at(0)

    the_product_category_one.name = params.fetch("query_name")

    if the_product_category_one.valid?
      the_product_category_one.save
      redirect_to("/product_category_ones/#{the_product_category_one.id}", { :notice => "Product category one updated successfully." } )
    else
      redirect_to("/product_category_ones/#{the_product_category_one.id}", { :alert => the_product_category_one.errors.full_messages.to_sentence })
    end
  end

  def destroy
    the_id = params.fetch("path_id")
    the_product_category_one = ProductCategoryOne.where({ :id => the_id }).at(0)

    the_product_category_one.destroy

    redirect_to("/product_category_ones", { :notice => "Product category one deleted successfully." } )
  end
end

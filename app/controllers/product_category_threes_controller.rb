class ProductCategoryThreesController < ApplicationController
  def index
    matching_product_category_threes = ProductCategoryThree.all

    @list_of_product_category_threes = matching_product_category_threes.order({ :created_at => :desc })

    render({ :template => "product_category_three_templates/index" })
  end

  def show
    the_id = params.fetch("path_id")

    matching_product_category_threes = ProductCategoryThree.where({ :id => the_id })

    @the_product_category_three = matching_product_category_threes.at(0)

    render({ :template => "product_category_three_templates/show" })
  end

  def create
    the_product_category_three = ProductCategoryThree.new
    the_product_category_three.name = params.fetch("query_name")
    the_product_category_three.product_category_two_id = params.fetch("query_product_category_two_id")

    if the_product_category_three.valid?
      the_product_category_three.save
      redirect_to("/product_category_threes", { :notice => "Product category three created successfully." })
    else
      redirect_to("/product_category_threes", { :alert => the_product_category_three.errors.full_messages.to_sentence })
    end
  end

  def update
    the_id = params.fetch("path_id")
    the_product_category_three = ProductCategoryThree.where({ :id => the_id }).at(0)

    the_product_category_three.name = params.fetch("query_name")
    the_product_category_three.product_category_two_id = params.fetch("query_product_category_two_id")

    if the_product_category_three.valid?
      the_product_category_three.save
      redirect_to("/product_category_threes/#{the_product_category_three.id}", { :notice => "Product category three updated successfully." } )
    else
      redirect_to("/product_category_threes/#{the_product_category_three.id}", { :alert => the_product_category_three.errors.full_messages.to_sentence })
    end
  end

  def destroy
    the_id = params.fetch("path_id")
    the_product_category_three = ProductCategoryThree.where({ :id => the_id }).at(0)

    the_product_category_three.destroy

    redirect_to("/product_category_threes", { :notice => "Product category three deleted successfully." } )
  end
end

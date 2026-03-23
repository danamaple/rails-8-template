class ProductCategoryTwosController < ApplicationController
  def index
    matching_product_category_twos = ProductCategoryTwo.all

    @list_of_product_category_twos = matching_product_category_twos.order({ :created_at => :desc })

    render({ :template => "product_category_two_templates/index" })
  end

  def show
    the_id = params.fetch("path_id")

    matching_product_category_twos = ProductCategoryTwo.where({ :id => the_id })

    @the_product_category_two = matching_product_category_twos.at(0)

    render({ :template => "product_category_two_templates/show" })
  end

  def create
    the_product_category_two = ProductCategoryTwo.new
    the_product_category_two.name = params.fetch("query_name")
    the_product_category_two.product_category_one_id = params.fetch("query_product_category_one_id")

    if the_product_category_two.valid?
      the_product_category_two.save
      redirect_to("/product_category_twos", { :notice => "Product category two created successfully." })
    else
      redirect_to("/product_category_twos", { :alert => the_product_category_two.errors.full_messages.to_sentence })
    end
  end

  def update
    the_id = params.fetch("path_id")
    the_product_category_two = ProductCategoryTwo.where({ :id => the_id }).at(0)

    the_product_category_two.name = params.fetch("query_name")
    the_product_category_two.product_category_one_id = params.fetch("query_product_category_one_id")

    if the_product_category_two.valid?
      the_product_category_two.save
      redirect_to("/product_category_twos/#{the_product_category_two.id}", { :notice => "Product category two updated successfully." } )
    else
      redirect_to("/product_category_twos/#{the_product_category_two.id}", { :alert => the_product_category_two.errors.full_messages.to_sentence })
    end
  end

  def destroy
    the_id = params.fetch("path_id")
    the_product_category_two = ProductCategoryTwo.where({ :id => the_id }).at(0)

    the_product_category_two.destroy

    redirect_to("/product_category_twos", { :notice => "Product category two deleted successfully." } )
  end
end

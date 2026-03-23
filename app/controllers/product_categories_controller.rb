class ProductCategoriesController < ApplicationController
  def index
    @category_ones = ProductCategoryOne.order(:name)
    @category_twos = ProductCategoryTwo.order(:name)
    @category_threes = ProductCategoryThree.order(:name)
    render({ :template => "product_category_templates/index" })
  end

  def create_one
    the_cat = ProductCategoryOne.new
    the_cat.name = params.fetch("query_name", "")

    if the_cat.valid?
      the_cat.save
      redirect_to("/product_categories", { :notice => "Category created successfully." })
    else
      redirect_to("/product_categories", { :alert => the_cat.errors.full_messages.to_sentence })
    end
  end

  def create_two
    the_cat = ProductCategoryTwo.new
    the_cat.name = params.fetch("query_name", "")
    the_cat.product_category_one_id = params.fetch("query_product_category_one_id")

    if the_cat.valid?
      the_cat.save
      redirect_to("/product_categories", { :notice => "Sub-category created successfully." })
    else
      redirect_to("/product_categories", { :alert => the_cat.errors.full_messages.to_sentence })
    end
  end

  def create_three
    the_cat = ProductCategoryThree.new
    the_cat.name = params.fetch("query_name", "")
    the_cat.product_category_two_id = params.fetch("query_product_category_two_id")

    if the_cat.valid?
      the_cat.save
      redirect_to("/product_categories", { :notice => "Sub-sub-category created successfully." })
    else
      redirect_to("/product_categories", { :alert => the_cat.errors.full_messages.to_sentence })
    end
  end
end

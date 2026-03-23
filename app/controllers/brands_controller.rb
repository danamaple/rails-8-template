class BrandsController < ApplicationController
  def index
    matching_brands = Brand.all

    @list_of_brands = matching_brands.order({ :created_at => :desc })

    render({ :template => "brand_templates/index" })
  end

  def show
    the_id = params.fetch("path_id")

    matching_brands = Brand.where({ :id => the_id })

    @the_brand = matching_brands.at(0)

    render({ :template => "brand_templates/show" })
  end

  def create
    the_brand = Brand.new
    the_brand.name = params.fetch("query_name")

    if the_brand.valid?
      the_brand.save
      redirect_to("/brands", { :notice => "Brand created successfully." })
    else
      redirect_to("/brands", { :alert => the_brand.errors.full_messages.to_sentence })
    end
  end

  def update
    the_id = params.fetch("path_id")
    the_brand = Brand.where({ :id => the_id }).at(0)

    the_brand.name = params.fetch("query_name")

    if the_brand.valid?
      the_brand.save
      redirect_to("/brands/#{the_brand.id}", { :notice => "Brand updated successfully." } )
    else
      redirect_to("/brands/#{the_brand.id}", { :alert => the_brand.errors.full_messages.to_sentence })
    end
  end

  def destroy
    the_id = params.fetch("path_id")
    the_brand = Brand.where({ :id => the_id }).at(0)

    the_brand.destroy

    redirect_to("/brands", { :notice => "Brand deleted successfully." } )
  end
end

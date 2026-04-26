class EmailTemplateProductsController < ApplicationController
  def index
    matching_email_template_products = EmailTemplateProduct.all

    @list_of_email_template_products = matching_email_template_products.order({ :created_at => :desc })

    render({ :template => "email_template_product_templates/index" })
  end

  def show
    the_id = params.fetch("path_id")

    matching_email_template_products = EmailTemplateProduct.where({ :id => the_id })

    @the_email_template_product = matching_email_template_products.at(0)

    render({ :template => "email_template_product_templates/show" })
  end

  def create
    the_email_template_id = params.fetch("query_email_template_id")

    the_email_template_product = EmailTemplateProduct.new
    the_email_template_product.email_template_id = the_email_template_id
    the_email_template_product.product_id = params.fetch("query_product_id")
    next_position = EmailTemplateProduct.where({ :email_template_id => the_email_template_id }).count + 1
    the_email_template_product.position = next_position

    if the_email_template_product.valid?
      the_email_template_product.save
      redirect_to("/email_templates/#{the_email_template_id}", { :notice => "Product added." })
    else
      redirect_to("/email_templates/#{the_email_template_id}", { :alert => the_email_template_product.errors.full_messages.to_sentence })
    end
  end

  def update
    the_id = params.fetch("path_id")
    the_email_template_product = EmailTemplateProduct.where({ :id => the_id }).at(0)

    the_email_template_product.email_template_id = params.fetch("query_email_template_id")
    the_email_template_product.product_id = params.fetch("query_product_id")
    the_email_template_product.position = params.fetch("query_position")

    if the_email_template_product.valid?
      the_email_template_product.save
      redirect_to("/email_template_products/#{the_email_template_product.id}", { :notice => "Email template product updated successfully." } )
    else
      redirect_to("/email_template_products/#{the_email_template_product.id}", { :alert => the_email_template_product.errors.full_messages.to_sentence })
    end
  end

  def destroy
    the_id = params.fetch("path_id")
    the_email_template_product = EmailTemplateProduct.where({ :id => the_id }).at(0)
    the_email_template_id = the_email_template_product.email_template_id

    the_email_template_product.destroy

    redirect_to("/email_templates/#{the_email_template_id}", { :notice => "Product removed." })
  end
end

class CustomerPricesController < ApplicationController
  def index
    matching_customer_prices = CustomerPrice.all

    @list_of_customer_prices = matching_customer_prices.order({ :created_at => :desc })

    render({ :template => "customer_price_templates/index" })
  end

  def show
    the_id = params.fetch("path_id")

    matching_customer_prices = CustomerPrice.where({ :id => the_id })

    @the_customer_price = matching_customer_prices.at(0)

    render({ :template => "customer_price_templates/show" })
  end

  def create
    the_customer_price = CustomerPrice.new
    the_customer_price.product_id = params.fetch("query_product_id")
    the_customer_price.company_id = params.fetch("query_company_id")
    the_customer_price.min_quantity = params.fetch("query_min_quantity", 1)
    the_customer_price.max_quantity = params.fetch("query_max_quantity", nil).presence
    the_customer_price.unit_price = params.fetch("query_unit_price")

    if the_customer_price.valid?
      the_customer_price.save
      redirect_to("/products/#{the_customer_price.product_id}", { :notice => "Customer price added." })
    else
      redirect_to("/products/#{the_customer_price.product_id}", { :alert => the_customer_price.errors.full_messages.to_sentence })
    end
  end

  def update
    the_id = params.fetch("path_id")
    the_customer_price = CustomerPrice.where({ :id => the_id }).at(0)

    the_customer_price.product_id = params.fetch("query_product_id")
    the_customer_price.company_id = params.fetch("query_company_id")
    the_customer_price.min_quantity = params.fetch("query_min_quantity")
    the_customer_price.max_quantity = params.fetch("query_max_quantity")
    the_customer_price.unit_price = params.fetch("query_unit_price")

    if the_customer_price.valid?
      the_customer_price.save
      redirect_to("/customer_prices/#{the_customer_price.id}", { :notice => "Customer price updated successfully." } )
    else
      redirect_to("/customer_prices/#{the_customer_price.id}", { :alert => the_customer_price.errors.full_messages.to_sentence })
    end
  end

  def destroy
    the_id = params.fetch("path_id")
    the_customer_price = CustomerPrice.where({ :id => the_id }).at(0)

    product_id = the_customer_price.product_id
    the_customer_price.destroy
    redirect_to("/products/#{product_id}", { :notice => "Customer price deleted successfully." })
  end
end

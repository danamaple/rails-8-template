class ProductPricesController < ApplicationController
  def index
    @list_of_product_prices = ProductPrice.all.order({ :created_at => :desc })
    render({ :template => "product_price_templates/index" })
  end

  def show
    the_id = params.fetch("path_id")
    @the_product_price = ProductPrice.where({ :id => the_id }).at(0)
    render({ :template => "product_price_templates/show" })
  end

  def create
    the_product_price = ProductPrice.new
    the_product_price.product_id = params.fetch("query_product_id")
    the_product_price.price_category_id = params.fetch("query_price_category_id")
    the_product_price.min_quantity = params.fetch("query_min_quantity")
    the_product_price.max_quantity = params.fetch("query_max_quantity", nil).presence
    the_product_price.unit_price = params.fetch("query_unit_price")

    if the_product_price.valid?
      the_product_price.save
      redirect_to("/products/#{the_product_price.product_id}", { :notice => "Price created successfully." })
    else
      redirect_to("/products/#{the_product_price.product_id}", { :alert => the_product_price.errors.full_messages.to_sentence })
    end
  end

  def update
    the_id = params.fetch("path_id")
    the_product_price = ProductPrice.where({ :id => the_id }).at(0)

    the_product_price.unit_price = params.fetch("query_unit_price")

    if the_product_price.valid?
      the_product_price.save
      respond_to do |format|
        format.json { render({ :json => { :success => true, :unit_price => the_product_price.unit_price } }) }
        format.html { redirect_to("/products/#{the_product_price.product_id}", { :notice => "Price updated." }) }
      end
    else
      respond_to do |format|
        format.json { render({ :json => { :success => false, :errors => the_product_price.errors.full_messages } }) }
        format.html { redirect_to("/products/#{the_product_price.product_id}", { :alert => the_product_price.errors.full_messages.to_sentence }) }
      end
    end
  end

  def split
    ActiveRecord::Base.connection.execute("SELECT setval('product_prices_id_seq', (SELECT MAX(id) FROM product_prices))")
    split_at = params.fetch("query_split_quantity").to_i
    product_id = params.fetch("path_id")

    PriceCategory.all.each do |pc|
      # Find the tier covering split_at for this category
      tier = ProductPrice.where({ :product_id => product_id, :price_category_id => pc.id })
                         .where("min_quantity <= ?", split_at)
                         .where("max_quantity IS NULL OR max_quantity >= ?", split_at)
                         .order(:min_quantity).last

      next unless tier

      original_min = tier.min_quantity
      original_max = tier.max_quantity
      original_price = tier.unit_price

      # Update existing tier: 1 to split_at
      tier.max_quantity = split_at
      tier.save

      # Create new tier: split_at+1 to original_max
      new_tier = ProductPrice.new
      new_tier.product_id = product_id
      new_tier.price_category_id = pc.id
      new_tier.min_quantity = split_at + 1
      new_tier.max_quantity = original_max
      new_tier.unit_price = original_price
      new_tier.save
    end

    # Fill any gaps with $0
    all_prices = ProductPrice.where({ :product_id => product_id }).order(:price_category_id, :min_quantity)
    tiers = all_prices.map { |p| p.min_quantity }.uniq.sort

    PriceCategory.all.each do |pc|
      tiers.each do |min_qty|
        existing = ProductPrice.where({ :product_id => product_id, :price_category_id => pc.id, :min_quantity => min_qty }).at(0)
        unless existing
          gap = ProductPrice.new
          gap.product_id = product_id
          gap.price_category_id = pc.id
          gap.min_quantity = min_qty
          gap.max_quantity = nil
          gap.unit_price = 0
          gap.save
        end
      end
    end

    redirect_to("/products/#{product_id}", { :notice => "Split at quantity #{split_at} applied." })
  end

  def destroy
    the_id = params.fetch("path_id")
    the_product_price = ProductPrice.where({ :id => the_id }).at(0)
    product_id = the_product_price.product_id
    the_product_price.destroy
    redirect_to("/products/#{product_id}", { :notice => "Price deleted successfully." })
  end
end

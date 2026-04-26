class ProductsController < ApplicationController
  def index
    @q = params.fetch("q", "")
    matching_products = Product.all
    if @q.present?
      matching_products = matching_products.where("name ILIKE ? OR sku ILIKE ? OR upc ILIKE ?", "%#{@q}%", "%#{@q}%", "%#{@q}%")
    end
    @list_of_products = matching_products.order({ :created_at => :desc })
    render({ :template => "product_templates/index" })
  end

  def new
    @brands = Brand.order(:name)
    @suppliers = Supplier.order(:name)
    @category_ones = ProductCategoryOne.order(:name)
    render({ :template => "product_templates/new" })
  end

  def show
    the_id = params.fetch("path_id")
    @the_product = Product.where({ :id => the_id }).at(0)
    @brands = Brand.order(:name)
    @suppliers = Supplier.order(:name)
    @category_ones = ProductCategoryOne.order(:name)
    @category_twos = ProductCategoryTwo.order(:name)
    @category_threes = ProductCategoryThree.order(:name)
    @custom_fields = CustomField.order(:field_name)
    @price_categories = PriceCategory.order(:name)
    # Build price matrix: tiers (unique min_qty across all categories)
    all_prices = @the_product.product_prices.order(:price_category_id, :min_quantity)
    @tiers = all_prices.map { |p| p.min_quantity }.uniq.sort
    @price_matrix = {}
    @price_categories.each do |pc|
      @price_matrix[pc.id] = {}
      all_prices.select { |p| p.price_category_id == pc.id }.each do |pp|
        @price_matrix[pc.id][pp.min_quantity] = pp
      end
    end
    @companies = Company.order(:company_name)
    @promotions_available = Promotion.order(:name)
    @lists_available = List.order(:name)
    render({ :template => "product_templates/show" })
  end

  def create
    the_product = Product.new
    the_product.sku = params.fetch("query_sku", "")
    the_product.name = params.fetch("query_name", "")
    the_product.description = params.fetch("query_description", "")
    the_product.frontend_name = params.fetch("query_frontend_name", "")
    the_product.upc = params.fetch("query_upc", "")
    the_product.flavour = params.fetch("query_flavour", "")
    the_product.size = params.fetch("query_size", "")
    the_product.weight = params.fetch("query_weight", "")
    the_product.supply_price = params.fetch("query_supply_price", nil)
    the_product.retail_price = params.fetch("query_retail_price", nil)
    the_product.is_active = params.fetch("query_is_active", false)
    the_product.new_arrival = params.fetch("query_new_arrival", false)
    the_product.new_arrival_date = params.fetch("query_new_arrival_date", nil).presence
    the_product.image_url = params.fetch("query_image_url", "")
    the_product.inventory_level = params.fetch("query_inventory_level", nil)
    the_product.track_inventory = params.fetch("query_track_inventory", false)
    the_product.reorder_quantity = params.fetch("query_reorder_quantity", nil)
    the_product.reorder_point = params.fetch("query_reorder_point", nil)
    the_product.brand_id = params.fetch("query_brand_id", nil).presence
    the_product.supplier_id = params.fetch("query_supplier_id", nil).presence
    the_product.product_category_one_id = params.fetch("query_product_category_one_id", nil).presence
    the_product.product_category_two_id = params.fetch("query_product_category_two_id", nil).presence
    the_product.product_category_three_id = params.fetch("query_product_category_three_id", nil).presence
    the_product.product_url = params.fetch("query_product_url", "")

    if the_product.valid?
      the_product.save
      # Auto-create one ProductPrice per PriceCategory
      PriceCategory.all.each do |pc|
        pp = ProductPrice.new
        pp.product_id = the_product.id
        pp.price_category_id = pc.id
        pp.min_quantity = 1
        pp.max_quantity = nil
        pp.unit_price = 0
        pp.save
      end
      redirect_to("/products/#{the_product.id}", { :notice => "Product created successfully." })
    else
      redirect_to("/products/new", { :alert => the_product.errors.full_messages.to_sentence })
    end
  end

  def update
    the_id = params.fetch("path_id")
    the_product = Product.where({ :id => the_id }).at(0)

    the_product.sku = params.fetch("query_sku", "")
    the_product.name = params.fetch("query_name", "")
    the_product.description = params.fetch("query_description", "")
    the_product.frontend_name = params.fetch("query_frontend_name", "")
    the_product.upc = params.fetch("query_upc", "")
    the_product.flavour = params.fetch("query_flavour", "")
    the_product.size = params.fetch("query_size", "")
    the_product.weight = params.fetch("query_weight", "")
    the_product.supply_price = params.fetch("query_supply_price", nil)
    the_product.retail_price = params.fetch("query_retail_price", nil)
    the_product.is_active = params.fetch("query_is_active", false)
    the_product.new_arrival = params.fetch("query_new_arrival", false)
    the_product.new_arrival_date = params.fetch("query_new_arrival_date", nil).presence
    the_product.image_url = params.fetch("query_image_url", "")
    the_product.inventory_level = params.fetch("query_inventory_level", nil)
    the_product.track_inventory = params.fetch("query_track_inventory", false)
    the_product.reorder_quantity = params.fetch("query_reorder_quantity", nil)
    the_product.reorder_point = params.fetch("query_reorder_point", nil)
    the_product.brand_id = params.fetch("query_brand_id", nil).presence
    the_product.supplier_id = params.fetch("query_supplier_id", nil).presence
    the_product.product_category_one_id = params.fetch("query_product_category_one_id", nil).presence
    the_product.product_category_two_id = params.fetch("query_product_category_two_id", nil).presence
    the_product.product_category_three_id = params.fetch("query_product_category_three_id", nil).presence
    the_product.product_url = params.fetch("query_product_url", "")

    if the_product.valid?
      the_product.save
      redirect_to("/products/#{the_product.id}", { :notice => "Product updated successfully." })
    else
      redirect_to("/products/#{the_product.id}", { :alert => the_product.errors.full_messages.to_sentence })
    end
  end

  def destroy
    the_id = params.fetch("path_id")
    the_product = Product.where({ :id => the_id }).at(0)
    the_product.destroy
    redirect_to("/products", { :notice => "Product deleted successfully." })
  end

  def export
    @list_of_products = Product.order(:name)
    headers["Content-Disposition"] = "attachment; filename=\"products.csv\""
    headers["Content-Type"] = "text/csv"
    render({ :template => "product_templates/export", :layout => false })
  end
end

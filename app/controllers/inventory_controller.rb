class InventoryController < ApplicationController
  def overview
    @products = Product.order(:name).includes(:brand, :product_category_one, :lots)
    @locations = Location.order(:name)
    @warehouses = @locations.select { |l| l.location_type == "warehouse" }
    @transit    = @locations.select { |l| l.location_type == "transit" }
    @stores     = @locations.select { |l| l.location_type == "store" }

    # { product_id => { location_id => total_qty } }
    @qty_by_product_location = {}
    # { product_id => { location_type => total_qty } }
    @qty_by_product_type = {}
    # { product_id => { reason => total_qty } }
    @removals_by_product_reason = {}

    lots = Lot.includes(:location).all
    lots.each do |lot|
      next unless lot.location
      pid = lot.product_id
      lid = lot.location_id
      ltype = lot.location.location_type

      @qty_by_product_location[pid] ||= {}
      @qty_by_product_location[pid][lid] = (@qty_by_product_location[pid][lid] || 0) + (lot.quantity || 0)

      @qty_by_product_type[pid] ||= {}
      @qty_by_product_type[pid][ltype] = (@qty_by_product_type[pid][ltype] || 0) + (lot.quantity || 0)
    end

    removals = InventoryRemoval.includes(:lot => :product).all
    removals.each do |r|
      next unless r.lot
      pid = r.lot.product_id
      reason = r.reason.presence || "other"
      @removals_by_product_reason[pid] ||= {}
      @removals_by_product_reason[pid][reason] = (@removals_by_product_reason[pid][reason] || 0) + (r.quantity || 0)
    end

    render({ :template => "inventory_templates/overview" })
  end

  def locations
    @warehouses = Location.where({ :location_type => "warehouse" }).order(:name)
    @transit    = Location.where({ :location_type => "transit" }).order(:name)
    @stores     = Location.where({ :location_type => "store" }).order(:name)
    render({ :template => "inventory_templates/locations" })
  end

  def location_detail
    the_id = params.fetch("path_id")
    @the_location = Location.where({ :id => the_id }).at(0)
    @lots = @the_location.lots.includes(:product, :supplier).order(:product_id, :lot_number)
    @all_locations = Location.order(:name)
    @products = Product.order(:name)
    @suppliers = Supplier.order(:name)
    render({ :template => "inventory_templates/location_detail" })
  end
end

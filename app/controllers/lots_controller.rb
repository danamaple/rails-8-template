class LotsController < ApplicationController
  def index
    @list_of_lots = Lot.all.order({ :created_at => :desc })
    render({ :template => "lot_templates/index" })
  end

  def show
    the_id = params.fetch("path_id")
    @the_lot = Lot.where({ :id => the_id }).at(0)
    render({ :template => "lot_templates/show" })
  end

  def create
    the_lot = Lot.new
    the_lot.product_id   = params.fetch("query_product_id")
    the_lot.location_id  = params.fetch("query_location_id")
    the_lot.supplier_id  = params.fetch("query_supplier_id", nil).presence
    the_lot.lot_number   = params.fetch("query_lot_number", "")
    the_lot.quantity     = params.fetch("query_quantity", 0).to_i
    the_lot.expiry_date  = params.fetch("query_expiry_date", nil).presence
    the_lot.received_date = Date.today

    if the_lot.valid?
      the_lot.save
      redirect_to("/inventory/locations/#{the_lot.location_id}", { :notice => "Inventory received successfully." })
    else
      redirect_to("/inventory/locations/#{the_lot.location_id}", { :alert => the_lot.errors.full_messages.to_sentence })
    end
  end

  def transfer
    source_lot_id = params.fetch("query_lot_id")
    dest_location_id = params.fetch("query_destination_location_id")
    transfer_qty = params.fetch("query_transfer_quantity", 0).to_i

    source_lot = Lot.where({ :id => source_lot_id }).at(0)

    if source_lot.nil?
      redirect_to("/inventory/locations", { :alert => "Lot not found." })
      return
    end

    if transfer_qty <= 0 || transfer_qty > source_lot.quantity
      redirect_to("/inventory/locations/#{source_lot.location_id}", { :alert => "Invalid transfer quantity. Available: #{source_lot.quantity}" })
      return
    end

    # Reduce source lot
    source_lot.quantity = source_lot.quantity - transfer_qty
    source_lot.save

    # Find or create destination lot
    dest_lot = Lot.where({
      :product_id  => source_lot.product_id,
      :location_id => dest_location_id,
      :supplier_id => source_lot.supplier_id,
      :lot_number  => source_lot.lot_number,
      :expiry_date => source_lot.expiry_date
    }).at(0)

    if dest_lot.nil?
      dest_lot = Lot.new
      dest_lot.product_id    = source_lot.product_id
      dest_lot.location_id   = dest_location_id
      dest_lot.supplier_id   = source_lot.supplier_id
      dest_lot.lot_number    = source_lot.lot_number
      dest_lot.expiry_date   = source_lot.expiry_date
      dest_lot.received_date = Date.today
      dest_lot.quantity      = 0
    end

    dest_lot.quantity = (dest_lot.quantity || 0) + transfer_qty
    dest_lot.save

    redirect_to("/inventory/locations/#{source_lot.location_id}", { :notice => "Transferred #{transfer_qty} units successfully." })
  end

  def update
    the_id = params.fetch("path_id")
    the_lot = Lot.where({ :id => the_id }).at(0)

    the_lot.product_id    = params.fetch("query_product_id")
    the_lot.location_id   = params.fetch("query_location_id")
    the_lot.supplier_id   = params.fetch("query_supplier_id", nil).presence
    the_lot.lot_number    = params.fetch("query_lot_number", "")
    the_lot.quantity      = params.fetch("query_quantity", 0)
    the_lot.expiry_date   = params.fetch("query_expiry_date", nil).presence
    the_lot.received_date = params.fetch("query_received_date", nil).presence

    if the_lot.valid?
      the_lot.save
      redirect_to("/inventory/locations/#{the_lot.location_id}", { :notice => "Lot updated successfully." })
    else
      redirect_to("/inventory/locations/#{the_lot.location_id}", { :alert => the_lot.errors.full_messages.to_sentence })
    end
  end

  def destroy
    the_id = params.fetch("path_id")
    the_lot = Lot.where({ :id => the_id }).at(0)
    location_id = the_lot.location_id
    the_lot.destroy
    redirect_to("/inventory/locations/#{location_id}", { :notice => "Lot deleted." })
  end
end

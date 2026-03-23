class InventoryRemovalsController < ApplicationController
  def index
    @list_of_inventory_removals = InventoryRemoval.all.order({ :created_at => :desc })
    render({ :template => "inventory_removal_templates/index" })
  end

  def show
    the_id = params.fetch("path_id")
    @the_inventory_removal = InventoryRemoval.where({ :id => the_id }).at(0)
    render({ :template => "inventory_removal_templates/show" })
  end

  def create
    lot_id     = params.fetch("query_lot_id")
    remove_qty = params.fetch("query_quantity", 0).to_i
    reason     = params.fetch("query_reason", "other")

    the_lot = Lot.where({ :id => lot_id }).at(0)

    if the_lot.nil?
      redirect_to("/inventory/locations", { :alert => "Lot not found." })
      return
    end

    if remove_qty <= 0 || remove_qty > the_lot.quantity
      redirect_to("/inventory/locations/#{the_lot.location_id}", { :alert => "Invalid quantity. Available: #{the_lot.quantity}" })
      return
    end

    the_removal = InventoryRemoval.new
    the_removal.lot_id       = lot_id
    the_removal.quantity     = remove_qty
    the_removal.reason       = reason
    the_removal.removed_date = Date.today
    the_removal.notes        = params.fetch("query_notes", "")

    if the_removal.valid?
      the_removal.save
      the_lot.quantity = the_lot.quantity - remove_qty
      the_lot.save
      redirect_to("/inventory/locations/#{the_lot.location_id}", { :notice => "Removed #{remove_qty} units (#{reason})." })
    else
      redirect_to("/inventory/locations/#{the_lot.location_id}", { :alert => the_removal.errors.full_messages.to_sentence })
    end
  end

  def update
    the_id = params.fetch("path_id")
    the_inventory_removal = InventoryRemoval.where({ :id => the_id }).at(0)

    the_inventory_removal.lot_id       = params.fetch("query_lot_id")
    the_inventory_removal.quantity     = params.fetch("query_quantity")
    the_inventory_removal.reason       = params.fetch("query_reason")
    the_inventory_removal.removed_date = params.fetch("query_removed_date")
    the_inventory_removal.notes        = params.fetch("query_notes")

    if the_inventory_removal.valid?
      the_inventory_removal.save
      redirect_to("/inventory_removals/#{the_inventory_removal.id}", { :notice => "Updated successfully." })
    else
      redirect_to("/inventory_removals/#{the_inventory_removal.id}", { :alert => the_inventory_removal.errors.full_messages.to_sentence })
    end
  end

  def destroy
    the_id = params.fetch("path_id")
    the_inventory_removal = InventoryRemoval.where({ :id => the_id }).at(0)
    the_inventory_removal.destroy
    redirect_to("/inventory_removals", { :notice => "Removal deleted." })
  end
end

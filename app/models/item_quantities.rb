class ItemQuantities
  def initialize(order)
    @order = order
  end

  def item_id_quantities
    Hash[@order.order_items.pluck(:item_id, :quantity)]
  end

  def items_and_quantities
    item_id_quantities.map do |id, quantity|
      [Item.find(id), quantity]
    end
  end

  def item_quantities
    Hash[items_and_quantities]
  end
end

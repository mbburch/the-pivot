class CartItem < SimpleDelegator
  attr_reader :item, :quantity

  def initialize(item, quantity)
    if quantity < 0
      quantity = 0
    end

    @item = item
    @quantity = quantity
  end

  def subtotal
    @item.price * @quantity
  end
end

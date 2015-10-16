class Cart
  attr_reader :cart

  def initialize(cart_data)
    cart_data ||= Hash.new(0)
    @cart = cart_data
  end

  def add_item(params)
    item = Item.find(params[:item_id].to_i)
    @cart[item.id.to_s] ||= 0
    @cart[item.id.to_s] += 1
  end

  def data
    @cart
  end

  def items
    @cart.map do |key, quantity|
      item = Item.find(key.to_i)
      CartItem.new(item, quantity)
    end
  end

  def total
    items.map(&:subtotal).sum
  end
end

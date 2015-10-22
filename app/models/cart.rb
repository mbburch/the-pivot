class Cart
  attr_reader :cart

  def initialize(cart_data)
    cart_data ||= Hash.new(0)
    @cart = cart_data
  end

  def add_item(params)
    item = {params[:item_id] => params[:amount].to_i}
    @cart.merge(item) do |_key, old_val, new_val|
      (old_val.to_i + new_val.to_i).to_s
    end
  end

  def checkout_status(auction)
    auction = Auction.find(auction)
    auction.status = "paid"
    auction.save
  end

  def data
    @cart
  end

  def total
    cart.values.sum
  end
end

class UserOrder
  def initialize(session, params)
    @session = session
    @params = params
  end

  def create_order
    require 'pry'; binding.pry
    @order = Order.create(user_id: @session[:user_id],
                          card_number: @params[:order][:card_number],
                          card_expiration: @params[:order][:card_expiration],
                          total_cost: Cart.new(@session[:cart]).total,
                          status: "Ordered")
  end

  def create_order_items
    @session[:cart].each do |item_id, quantity|
      OrderItem.create(item_id: item_id,
                       quantity: quantity,
                       order_id: @order.id)
    end
  end
end

class UserOrder
  def self.create_order(params, current_user, cart)
    Order.create(user_id: current_user.id,
             card_number: params[:card_number],
         card_expiration: params[:card_expiration],
              total_cost: cart.total,
                  status: "Ordered")
  end
end

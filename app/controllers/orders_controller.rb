class OrdersController < ApplicationController
  def new
    if current_user
      @orders = Order.new
    else
      flash[:notice] = "Please Login or Create an Account to Checkout"
      redirect_to login_path
    end
  end

  def create
    @order = Order.create_order(order_params, current_user, cart)
    flash[:notice] = "Order successful!"
    redirect_to order_path(@order.id)
  end

  def show
    @order = Order.find(params[:id])
    @items = find_items
    if @order
      @user = User.find(@order.user_id)
    else
      render file: "/public/404"
    end
    session[:cart].clear
  end

  private

  def order_params
    params.require(:order).permit(:card_number, :card_expiration)
  end

  def find_items
    items = []
    item_ids = cart.data.keys
    item_ids.each do |id|
      items << Item.find(id)
    end
    items
  end
end

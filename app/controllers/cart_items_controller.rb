class CartItemsController < ApplicationController
  def create
    cart.checkout_status(params[:cart][:auction])
    session[:cart] = cart.add_item(cart_params)
    redirect_to :back
  end

  def index
    item = cart.data.keys
    @items = Item.find(item)
    @total = cart.total
  end

  private

  def cart_params
    params.require(:cart).permit(:amount, :item_id)
  end
end

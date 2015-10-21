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

  def update
    change_quantity(params)
    redirect_to "/cart"
  end

  def destroy
    delete_item(params)
    delete_notice
    redirect_to "/cart"
  end

  private

  def cart_params
    params.require(:cart).permit(:amount, :item_id)
  end

  def redirect(params)
    redirect_to params[:path]
  end

  def change_quantity(params)
    session[:cart][params[:id]] = params[:item_quantity][:quantity].to_i
  end

  def delete_item(params)
    cart = session[:cart]
    cart.delete(params[:id])
  end

  def delete_notice
    item = Item.find(params[:id])
    flash[:notice] = "Successfully removed <a href=/items/#{params[:id]}>
      #{item.title}</a> from your cart."
  end
end

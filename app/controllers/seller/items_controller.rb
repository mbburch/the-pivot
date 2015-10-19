class Seller::ItemsController < Seller::SellersController
  def show
    @item = Item.find(params[:id])
  end
end
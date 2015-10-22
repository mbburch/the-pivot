class ItemsController < ApplicationController
  def show
    @item = Item.find(params[:id])
    @bids = @item.bids
  end
end

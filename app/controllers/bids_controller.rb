class BidsController < ApplicationController

  def create
    item = Item.find(params[:bid][:origin_page])
    current_bid = item.current_bid
    bid = Bid.new(bid_params)
    if bid.amount > current_bid
      auction = Auction.find_by(item_id: item)
      bid[:auction_id] = auction.id
      bid.save
      flash[:notice] = "Your bid has been placed. Good luck!"
    else
      flash[:notice] = "Your bid is invalid. Please try again!"
    end
    redirect_to item_path(params[:bid][:origin_page])
  end

  private

  def bid_params
    params.require(:bid).permit(:amount, :user_id)
  end
end

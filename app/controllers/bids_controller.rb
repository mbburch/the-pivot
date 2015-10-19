class BidsController < ApplicationController

  def create
    bid = Bid.new(bid_params)
    auction = Auction.find_by(item_id: params[:bid][:origin_page])

    if bid.greater?(auction)
      bid[:auction_id] = auction.id
      bid.save
      flash[:notice] = "You are the highest bidder! Good luck!"
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

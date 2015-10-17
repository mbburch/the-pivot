class BidsController < ApplicationController

  def create
    bid = Bid.create(bid_params)
    if bid.save
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

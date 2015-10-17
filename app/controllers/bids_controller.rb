class BidsController < ApplicationController

  def create
    if validate_params
      Bid.create(bid_params)
      flash[:notice] = "Your bid has been placed!"
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

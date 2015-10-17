class BidsController < ApplicationController

  def create
    if validate_params
      Bid.create(bid_params)
      flash[:success] = "Your bid has been placed!"
    else
      require 'pry'; binding.pry
      flash[:errors] = "Invalid Bid."
    end
    redirect_to item_path(params[:bid][:origin_page])
  end

  private

  def bid_params
    params.require(:bid).permit(:amount, :user_id)
  end
end

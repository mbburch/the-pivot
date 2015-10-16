class BidsController < ApplicationController

  def create
    @bid = Bid.new(bid_params)
    @bid.assign_attributes(user_id: params[:bid][:user_id])
    redirect_to items_path
  end

  private

  def bid_params
    params.require(:bid).permit(:amount)
  end
end

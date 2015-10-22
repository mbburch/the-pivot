class AuctionsController < ApplicationController
  def index
    if params[:search]
      @auctions =Auction.search(params[:search]).order("created_at DESC")
      flash[:alert] = "We found the following results"
    else
      @auctions = Auction.where(status: "open")
    end
  end
end

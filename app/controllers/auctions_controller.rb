class AuctionsController < ApplicationController
  def index
    @auctions = Auction.all
  end

  def create
    auction = Auction.create(auction_params)
    if auction.save
      flash[:notice] = "Your auction is all set!"
    else
      flash[:notice] = "Please make sure you have filled in all of the fields."
    end
  end

  private

    def auction_params
      params.require(:auction).permit(:starting_price, :item_id)
    end
end
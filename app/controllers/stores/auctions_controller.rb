class Stores::AuctionsController < ApplicationController

  def index
    @auctions = Auction.all
  end

  private

    def auction_params
      params.require(:auction).permit(:starting_price, :item_id)
    end
end

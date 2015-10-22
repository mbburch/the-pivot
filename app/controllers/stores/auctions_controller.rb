class Stores::AuctionsController < ApplicationController

  def index
    @auctions = Store.find_by(slug: params[:store]).items.flat_map(&:auctions)
  end

  private

    def auction_params
      params.require(:auction).permit(:starting_price, :item_id)
    end
end

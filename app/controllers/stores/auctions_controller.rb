class Stores::AuctionsController < ApplicationController

  def index
    @auctions = Store.find_by(slug: params[:store]).items.flat_map(&:auctions)
  end
end

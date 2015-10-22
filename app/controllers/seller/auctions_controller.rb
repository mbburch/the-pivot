class Seller::AuctionsController < Seller::SellersController

  def index
    @auctions = Store.find_by(slug: params[:store]).items.flat_map(&:auctions)
  end

  def new
    @seller = User.find_by(username: params[:seller])
    @items  = @seller.items
  end

  def create
    auction = Auction.new(auction_params)
    if valid_time(auction)
      if auction.save
        flash[:notice] = "Your auction is all set!"
        redirect_to seller_dashboard_path
      else
        flash[:notice] = auction.errors.full_messages.join(", ")
        redirect_to :back
      end
    else
      time_redirect
    end
  end

  private

    def auction_params
      params.require(:auction).permit(:starting_price, :item_id, :starting_time, :ending_time)
    end

    def valid_time(auction)
      auction.starting_time < auction.ending_time
    end

    def time_redirect
      flash[:notice] = "Please select an end time later than start time."
      redirect_to :back
    end
end

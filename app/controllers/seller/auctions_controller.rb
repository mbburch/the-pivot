class Seller::AuctionsController < Seller::SellersController

  def index
    @auctions = Store.find_by(slug: params[:store]).items.flat_map(&:auctions)
  end

  def new
    @seller = User.find_by(username: params[:seller])
    @items  = @seller.items
  end

  def create
    auction = Auction.create(auction_params.except(:store_id))
    if auction.save
      flash[:notice] = "Your auction is all set!"
      redirect_to seller_dashboard_path
    else
      flash[:notice] = auction.errors.full_messages.join(", ")
      redirect_to :back
    end

  end

  private

    def auction_params
      params.require(:auction).permit(:starting_price, :item_id, :starting_time, :ending_time)
    end
end

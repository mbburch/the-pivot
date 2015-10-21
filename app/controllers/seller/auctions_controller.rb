class Seller::AuctionsController < Seller::SellersController

  def index
    @auctions = Auction.all
  end

  def new
    @seller = User.find_by(username: params[:seller])
    @items  = @seller.items
  end

  def create
    byebug
    auction = Auction.create(auction_params.except(:store_id))
    if auction.save
      flash[:notice] = "Your auction is all set!"
    else
      flash[:notice] = "Please make sure you have filled in all of the fields."
    end
    redirect_to :back
  end

  private

    def auction_params
      params.require(:auction).permit(:starting_price, :item_id, :starting_time, :ending_time)
    end
end

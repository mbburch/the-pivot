class Admin::AuctionsController < Admin::BaseController

  def index
    @auctions = Auction.where(status: "open")
  end

  def destroy
    auction = Auction.find(auction_params[:id])
    auction.status = "closed"
    auction.save
    flash[:notice] = "The auction for #{auction.item.title} has been cancelled."
    redirect_to :back
  end

  private

  def auction_params
    params.permit(:id)
  end
end
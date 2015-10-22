class Bid < ActiveRecord::Base
  belongs_to :user
  belongs_to :auction
  has_one :item, through: :auction

  validates :amount, :numericality => { :greater_than => 0}, presence: true
  validates :user_id, presence: true

  def greater?(auction)
    if auction.bids.count > 0
      amount > auction.highest_bid
    else
      amount > auction.starting_price
    end
  end

  def status
    if amount >= auction.highest_bid
      status = "Winning Bid"
    else
      status = "Losing Bid"
    end
  end

  def losing?
    status == "Losing Bid" && auction_open?
  end

  def auction_open?
    auction.status == "open"
  end

  def winning?
    status == "Winning Bid" && auction_closed?
  end

  def auction_closed?
    auction.status == "closed"
  end
end

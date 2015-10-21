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
end

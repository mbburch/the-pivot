class Bid < ActiveRecord::Base
  belongs_to :user
  belongs_to :auction
  has_one :item, through: :auction

  validates :amount, :numericality => { :greater_than => 0}, presence: true

  def greater?(auction)
    if auction.bids.count > 0
      self.amount > auction.highest_bid
    else
      self.amount > auction.starting_price
    end
  end

  def status
    highest_bid = self.auction.highest_bid
    if self[:amount] >= highest_bid
      self[:status] = "Winning Bid"
    else
      self[:status] = "Losing Bid"
    end
  end
end

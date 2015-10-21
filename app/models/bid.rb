class Bid < ActiveRecord::Base
  belongs_to :user
  belongs_to :auction
  has_one :item, through: :auction

  validates :amount, :numericality => { :greater_than => 0}, presence: true
  validates :user_id, presence: true

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
      payment_status
    else
      self[:status] = "Losing Bid"
    end
  end

  def payment_status
    if self.auction.status == "over"
      self[:status] = "pending"
    else
      self[:status] = "Winning Bid"
    end
  end
end

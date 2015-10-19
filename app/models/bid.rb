class Bid < ActiveRecord::Base
  belongs_to :user
  belongs_to :auction

  validates :amount, :numericality => { :greater_than => 0}, presence: true

  def status
    highest_bid = self.auction.highest_bid
    if self[:amount] >= highest_bid
      self[:status] = "Winning Bid"
    else
      self[:status] = "Losing Bid"
    end
  end
end

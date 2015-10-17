class Bid < ActiveRecord::Base
  belongs_to :user
  belongs_to :auction

  validates :amount, :numericality => { :greater_than => 0}, presence: true

  before_save :higher?

  def higher?
    if auction.bids.count > 0
      self.amount > auction.bids.last.amount
    else
      self.amount > auction.starting_price
    end
  end
end

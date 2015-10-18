class Auction < ActiveRecord::Base
  has_many :bids
  has_many :users, through: :bids
  belongs_to :item

  validates :starting_price, presence: true

  def highest_bid
    bids.maximum(:amount)
  end
end
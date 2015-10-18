class Auction < ActiveRecord::Base
  has_many :bids
  has_many :users, through: :bids
  belongs_to :item

  validates :starting_price, presence: true

  delegate :starting_price, to: :items

  def highest_bid
    bids.maximum(:amount)
  end
end
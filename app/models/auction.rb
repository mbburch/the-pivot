class Auction < ActiveRecord::Base
  has_many :bids
  has_many :users, through: :bids
  belongs_to :item
  has_one :category, through: :item

  validates :starting_price, presence: true

  def highest_bid
    bids.maximum(:amount)
  end

  def self.search(query)
    joins(:item).where("title like ?", "%#{query}%")
  end
end

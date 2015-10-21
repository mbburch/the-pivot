class Auction < ActiveRecord::Base

  has_many :bids
  has_many :users, through: :bids
  belongs_to :item
  has_one :category, through: :item

  validates :starting_price, :numericality => { :greater_than => 0}, presence: true
  validates :item_id, presence: true

  def self.search(query)
    joins(:item).where("title like ?", "%#{query}%")
  end

  def highest_bid
    bids.maximum(:amount)
  end

  def self.open
    where('starting_time <= ?', Time.now).where('ending_time >= ?', Time.now)
  end

  def status
    if starting_time < Time.now && ending_time > Time.now
      "open"
    elsif starting_time > Time.now
      "scheduled"
    elsif ending_time < Time.now
      "ended"
    end
  end

  def winner
    winner = bids.max_by do |bid|
      bid.amount
    end
    winner.user
  end
end

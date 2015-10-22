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

  def update_status
    if starting_time < Time.now && ending_time > Time.now
      status = "open"
    elsif starting_time > Time.now
      status = "scheduled"
    elsif ending_time < Time.now
      status = "ended"
    end
  end

  # def self.check_date
  #   starting_time < ending_time
  # end
  #
  # def self.cancel_bid
  #   flash[:notice] = "Please select an end time later than start time."
  #   redirect_to :back
  # end

  def winner
    winner = bids.max_by do |bid|
      bid.amount
    end
    winner.user
  end
end

class Item < ActiveRecord::Base
  validates :title, presence: true, uniqueness: true
  validates :description, presence: true
  validates :category, presence: true

  belongs_to :category
  belongs_to :store
  has_many :auctions
  has_many :bids, through: :auctions

  has_attached_file :avatar,
                    styles: { medium: "800x300#", thumb: "320x150#" },
                    default_url: "https://s3.amazonaws.com/mb-the-pivot/Original_1976_Apple_1_Computer_In_A_Briefcase.JPG"
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\Z/

  def current_bid
    if bids.maximum(:amount) == nil
      0
    else
      bids.maximum(:amount)
    end
  end

  def starting_price
    auction = Auction.find_by(item_id: self)
    auction.starting_price
  end
end

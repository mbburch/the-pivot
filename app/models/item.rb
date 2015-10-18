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
                    default_url: "https://s3.amazonaws.com/turing-denvestments/assets/Richard_Stallman_by_Anders_Brenna_01.jpg"
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\Z/

  def current_price
    auction = Auction.find_by(item_id: self[:id])
    if auction
      auction[:starting_price]
    else
      "This item is not available at the moment. Check back soon!"
    end
  end
end

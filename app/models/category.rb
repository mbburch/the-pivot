class Category < ActiveRecord::Base
  has_many :items
  has_many :auctions, through: :items

  validates :name, presence: true, uniqueness: true
end

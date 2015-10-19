class User < ActiveRecord::Base
  has_many :orders
  has_many :stores
  has_many :bids
  has_many :items

  validates :username, presence: true, uniqueness: true
  validates :full_name, presence: true
  validates :address, presence: true
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true,
                    length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }

  has_secure_password

  enum role: %w(default admin seller)
end

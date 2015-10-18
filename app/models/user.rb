class User < ActiveRecord::Base
  has_many :orders
  has_many :stores
  has_many :items

  validates :username, presence: true, uniqueness: true
  validates :full_name, presence: true
  validates :address, presence: true
  validates :email, presence: true

  has_secure_password

  enum role: %w(default admin seller)
end

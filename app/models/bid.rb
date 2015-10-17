class Bid < ActiveRecord::Base
  belongs_to :user
  belongs_to :auction

  validates :amount, :numericality => { :greater_than => 0}, presence: true
end

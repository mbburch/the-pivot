class Store < ActiveRecord::Base
  belongs_to :user
  has_many :loans

  validates :name, uniqueness: true, presence: true
  validates :user_id, presence: true

  before_validation :capitalize

  def capitalize
    self.name = name.to_s.capitalize
  end
end

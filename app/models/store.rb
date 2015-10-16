class Store < ActiveRecord::Base
  belongs_to :user
  has_many :items

  validates :title, uniqueness: true, presence: true
  validates :user_id, presence: true

  before_validation :capitalize

  def capitalize
    self.title = title.to_s.capitalize
  end
end

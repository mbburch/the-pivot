class Store < ActiveRecord::Base
  belongs_to :user
  has_many :items

  validates :title, uniqueness: true, presence: true
  validates :description, presence: true
  validates :slug, uniqueness: true, presence: true
  validates :user_id, presence: true

  before_validation :capitalize, :generate_slug

  def capitalize
    self.title = title.to_s.titleize
  end

  def generate_slug
    self.slug = title.parameterize
  end


end

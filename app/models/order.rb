class Order < ActiveRecord::Base
  has_many :order_items
  belongs_to :user

  validates :user_id, presence: true
  validates :status,
            presence: true,
            inclusion: { in: %w( Ordered Paid Cancelled Completed),
                         message: "%{value} is not a valid status" }
  validates :card_number, presence: true
  validates :card_expiration, presence: true

  def date
    created_at.strftime("%b %d, %Y")
  end

  def self.create_order(params, current_user, cart)
    Order.create(user_id: current_user.id,
             card_number: params[:card_number],
         card_expiration: params[:card_expiration],
              total_cost: cart.total,
                  status: "Ordered")
  end
end

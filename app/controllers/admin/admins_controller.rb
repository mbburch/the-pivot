class Admin::AdminsController < Admin::BaseController
  def show
    @completed = Order.where(status: "Completed")
    @paid = Order.where(status: "Paid")
    @cancelled = Order.where(status: "Cancelled")
    @ordered = Order.where(status: "Ordered")
  end
end

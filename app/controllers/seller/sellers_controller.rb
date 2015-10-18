class Seller::SellersController < ApplicationController
  before_action :authorize_seller

  private

  def authorize_seller
    if current_user == nil
      redirect_to '/'
    elsif current_user.username != params[:seller]
      redirect_to seller_dashboard_path(current_user.username)
    end
  end
end

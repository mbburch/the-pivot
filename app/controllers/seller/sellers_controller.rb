class Seller::SellersController < ApplicationController
  before_action :authorize_seller

  def show
  end

  def edit
    @seller = current_user
  end

  def update
    seller = User.find(current_user.id)
    if seller.update(seller_params)
      redirect_to seller_dashboard_path
    else
      flash[:notice] = seller.errors.full_messages.join(", ")
      redirect_to seller_edit_path
    end
  end

  private

  def seller_params
    params.require(:user).permit(:username, :password, :full_name, :address, :email)
  end

  def authorize_seller
    if current_user == nil
      redirect_to '/'
    elsif current_user.username != params[:seller]
      redirect_to seller_dashboard_path(current_user.username)
    end
  end
end

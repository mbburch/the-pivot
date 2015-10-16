class UsersController < ApplicationController
  def show
    if !current_user
      redirect_to "/"
    elsif current_admin?
      redirect_to "/admin/dashboard"
    elsif current_seller?
      redirect_to "/seller/dashboard"
    end
  end

  def new
    require 'pry'; binding.pry
    @user = User.new
  end

  def create
    user = User.new(user_params)
    if user.save
      session[:user_id] = user.id
      redirect_to dashboard_path
    else
      flash[:notice] = user.errors.full_messages.join(", ")
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit(:username, :password, :full_name, :address)
  end
end

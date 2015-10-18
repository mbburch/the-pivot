class UsersController < ApplicationController
  def show
    if !current_user
      redirect_to "/"
    elsif current_admin?
      redirect_to admin_dashboard_path
    elsif current_seller?
      redirect_to seller_dashboard_path(current_user.username)
    end
  end

  def new
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

  def edit
    @user = current_user
  end

  def update
    user = User.find(current_user.id)
    if user.update(user_params)
      redirect_to dashboard_path
    else
      flash[:notice] = user.errors.full_messages.join(", ")
      redirect_to edit_path
    end
  end

  private

  def user_params
    params.require(:user).permit(:username, :password, :full_name, :address, :email)
  end
end

class SessionsController < ApplicationController

  def create
    user = User.find_by(username: user_params[:username])
    if user && user.authenticate(user_params[:password])
      session[:user_id] = user.id
      redirect_to "/dashboard"
    else
      flash[:notice] = "Incorrect login"
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    session[:cart] = nil
    redirect_to root_path
  end

  private

  def user_params
    params.require(:user).permit(:username, :password)
  end
end

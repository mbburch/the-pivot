class BidsController < ApplicationController

  def create
    flash[:notice] = "Please Login or Create an Account to Place a Bid"
    redirect_to login_path
  end
end

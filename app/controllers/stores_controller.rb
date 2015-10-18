class StoresController < ApplicationController
  def new
  end

  def create
    @store = Store.new(store_params)
    @store.assign_attributes(title: params[:store][:title],
                       description: params[:store][:description],
                           user_id: params[:user_id])
    @store.save
    redirect_to seller_dashboard_path(current_user)
  end

  def index
    @stores = Store.all
  end

  def destroy

    store = Store.find(params[:id])
    store.delete
    redirect_to seller_dashboard_path(current_user)
  end

  private

  def store_params
    params.require(:store).permit(:title, :description, :user_id)
  end


end

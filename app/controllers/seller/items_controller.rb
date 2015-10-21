class Seller::ItemsController < Seller::SellersController
  def new
    @seller = User.find_by(username: params[:seller])
    @stores = @seller.stores
  end

  def create
    item = Item.new(item_params)
    if item.save
      flash[:notice] = "#{item.title} was successfully created."
      redirect_to seller_dashboard_path
    else
      flash[:notice] = "Please try again. #{item.errors.full_messages.join(", ")}."
      redirect_to new_seller_item_path
    end
  end

  def show
    @item = Item.find(params[:id])
  end

  private

  def item_params
    params.require(:item).permit(:title,
                                 :description,
                                 :store_id,
                                 :category_id,
                                 :status,
                                 :avatar)
  end
end
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

  def edit
    @item = Item.find(params[:id])
    @seller = User.find_by(username: params[:seller])
  end

  def update
    item = Item.find(params[:id])
    if item.update(item_params)
      flash[:notice] = "#{item.title} was successfully edited."
      redirect_to seller_item_path
    else
      flash[:notice] = item.errors.full_messages.join(", ")
      redirect_to edit_seller_item_path
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
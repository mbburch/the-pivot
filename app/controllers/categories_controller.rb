class CategoriesController < ApplicationController
  def show
    @category = Category.find(params[:id])
    @auctions = @category.auctions
  end
end

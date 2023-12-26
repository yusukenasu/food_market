class FavoritesController < ApplicationController
  def create
    @product = Product.find(params[:product_id])
    @product_favorite = Favorite.new(user_id: current_user.id, product_id: params[:product_id])
    @product_favorite.save
    # redirect_to product_path(params[:product_id])
  end

  def destroy
    @product = Product.find(params[:product_id])
    @product_favorite = Favorite.find_by(user_id: current_user.id, product_id: params[:product_id])
    @product_favorite.destroy
    # redirect_to product_path(params[:product_id]) 
  end
end

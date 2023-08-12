class ProductsController < ApplicationController
  def index
    @user = current_user
    @products = Product.all
  end

  def new
    @user = current_user
    @product = Product.new
  end

  def show
    @user = current_user
    @product = Product.find(params[:id])
  end

  def create
    @user = current_user
    @product = Product.new(params.require(:product).permit(:name))
    if @product.save
      redirect_to products_path
    else
      render :new
    end
  end

  def edit
    @user = current_user
    @product = Product.find(params[:id])
  end

  def update
    @user = current_user
    @product = Product.find(params[:id])
    if @product.update(params.require(:product).permit(:name))
      redirect_to :products
    else
      render "edit"
    end
  end

  def destroy
    @product = Product.find(params[:id])
    @product.destroy
    redirect_to :products
  end 

end

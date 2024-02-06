class ProductsController < ApplicationController
  def index
    @user = current_user
    @products = Product.all.includes(:user)
    @random_products = Product.order("RAND()").limit(5).includes(:user)
  end

  def show
    @user = current_user
    @product = Product.find(params[:id])
    gon.reasonability = @product.point_of_reasonability
    gon.impression = @product.point_of_impression
    gon.taste = @product.point_of_taste
    gon.repeatability = @product.point_of_repeatability
    gon.design = @product.point_of_design
    @items = RakutenWebService::Ichiba::Item.search(keyword: "#{@product.name} #{@product.manufacturer}")
  end

  def new
    @user = current_user
    @product = Product.new
  end

  def create
    @user = current_user
    @product = Product.new(product_params)
    if @product.save
      redirect_to product_path(@product)
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
    if @product.update(product_params)
      redirect_to product_path
    else
      render :edit
    end
  end

  def destroy
    @product = Product.find(params[:id])
    @product.destroy
    redirect_to users_home_path
  end 

  def search
    @user = current_user
    @searched_products = Product.looks(params[:word])
  end

  private
  def product_params 
    params.require(:product).permit(
      :name, :manufacturer, :price, :category,
      :description, :point_of_reasonability,
      :point_of_impression, :point_of_taste,
      :point_of_repeatability, :point_of_design,
      :image, :user_id
    )
  end
end

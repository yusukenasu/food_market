class ProductsController < ApplicationController
  def index
    @user = current_user
    @products = Product.all
    @random_products = Product.order("RAND()").limit(10)
    if user_signed_in?
      @user_products = @user.products
    end
  end

  def new
    @user = current_user
    @product = Product.new
  end

  def show
    @user = current_user
    @product = Product.find(params[:id])
    @contributor = @product.user
    gon.reasonability = @product.point_of_reasonability
    gon.impression = @product.point_of_impression
    gon.taste = @product.point_of_taste
    gon.repeatability = @product.point_of_repeatability
    gon.design = @product.point_of_design
    @items = RakutenWebService::Ichiba::Item.search(keyword: "#{@product.name} #{@product.manufacturer}")
  end

  def create
    @user = current_user
    @product = Product.new(product_params)
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
    if @product.update(product_params)
      redirect_to :product
    else
      render "edit"
    end
  end

  def destroy
    @product = Product.find(params[:id])
    @product.destroy
    redirect_to :products
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

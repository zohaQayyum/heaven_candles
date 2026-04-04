class ProductsController < ApplicationController
  before_action :authenticate_user!

  def index
    @products = Product.includes(:category, :product_variants).all
  end
  
  def show
    @product = Product.includes(:category, :product_variants).find(params[:id])
  end
end

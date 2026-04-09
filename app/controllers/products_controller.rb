class ProductsController < ApplicationController
  before_action :authenticate_user!

  def index
    @products = Product.includes(:category, :product_variants).all
    @products = @products.search_by_name_and_description(params[:search]) if params[:search].present?
  end
  
  def show
    @product = Product.includes(:category, :product_variants).find(params[:id])
  end
end

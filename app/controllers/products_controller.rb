class ProductsController < ApplicationController
  def index
    @categories = Category.order(:name)
    
    @products = Product.includes(:category, :product_variants)
    @products = @products.search_by_name_and_description(params[:search]) if params[:search].present?
    @products = @products.where(category_id: params[:category_id]) if params[:category_id].present?
  end
  
  def show
    @product = Product.includes(:category, :product_variants).find(params[:id])
    @reviews = @product.reviews.approved.order(created_at: :desc)
  end
end

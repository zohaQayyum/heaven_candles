class ProductsController < ApplicationController
  before_action :authenticate_user!

  def index
    @products = Product.includes(:category, :product_variants).all
  end
end

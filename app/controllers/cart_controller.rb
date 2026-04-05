class CartController < ApplicationController
  before_action :authenticate_user!
  before_action :initialize_cart
  before_action :find_variant, only: [:add, :increment, :decrement, :remove]

  def show
    @variants = ProductVariant.includes(:product).where(id: @cart.keys)
    @total = @variants.sum { |v| v.price * @cart[v.id.to_s] }
  end

  def add
    current_quantity = @cart[@variant.id.to_s] || 0

    if current_quantity >= @variant.stock
      redirect_to product_path(@variant.product), alert: "Sorry, only #{@variant.stock} available in stock!"
    else
      @cart[@variant.id.to_s] = current_quantity + 1
      redirect_to product_path(@variant.product), notice: "Added to cart!"
    end
  end

  def increment
    if @cart[@variant.id.to_s] < @variant.stock
      @cart[@variant.id.to_s] += 1
    else
      flash[:alert] = "Sorry, only #{@variant.stock} available in stock!"
    end
    redirect_to cart_path
  end

  def decrement
    if @cart[@variant.id.to_s] > 1
      @cart[@variant.id.to_s] -= 1
    else
      @cart.delete(@variant.id.to_s)
    end
    redirect_to cart_path
  end

  def remove
    @cart.delete(@variant.id.to_s)
    redirect_to cart_path, notice: "Item removed from cart!"
  end

  private

  def initialize_cart
    session[:cart] ||= {}
    @cart = session[:cart]
  end

  def find_variant
    @variant = ProductVariant.includes(:product).find(params[:variant_id])
  end
end

class CartController < ApplicationController
  before_action :find_variant, only: [:add]

  def show
    @cart = current_cart
    @cart_items = @cart.cart_items.includes(product_variant: :product)
    @total = @cart_items.sum { |item| item.product_variant.price * item.quantity }
  end

  def add
    cart = current_cart
    cart_item = cart.cart_items.find_or_initialize_by(product_variant: @variant)
    requested = [params[:quantity].to_i, 1].max
 
    if cart_item.quantity.to_i + requested > @variant.stock
      redirect_to product_path(@variant.product), alert: "Sorry, only #{@variant.stock} available in stock!"
    else
      current_quantity = cart_item.new_record? ? 0 : cart_item.quantity.to_i
      cart_item.quantity = current_quantity + requested
      cart_item.save!
      redirect_to product_path(@variant.product), notice: "Added to cart!"
    end
  end

  def increment
    cart = current_cart
    cart_item = cart.cart_items.find_by_id(params[:id])
    if cart_item.quantity < cart_item.product_variant.stock
      cart_item.quantity += 1
      cart_item.save!
    else
      flash[:alert] = "Sorry, only #{cart_item.product_variant.stock} available in stock!"
    end
    redirect_to cart_path
  end

  def decrement
    cart = current_cart
    cart_item = cart.cart_items.find_by_id(params[:id])
    if cart_item.quantity  > 1
      cart_item.quantity -= 1
      cart_item.save!
    else
      cart_item.destroy
    end
    redirect_to cart_path
  end

  def remove
    cart = current_cart
    cart_item = cart.cart_items.find_by_id(params[:id])
    cart_item.destroy
    redirect_to cart_path, notice: "Item removed from cart!"
  end

  private

  def find_variant
    @variant = ProductVariant.includes(:product).find(params[:variant_id])
  end
end

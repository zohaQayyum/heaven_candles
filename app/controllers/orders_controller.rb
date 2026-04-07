class OrdersController < ApplicationController
  before_action :authenticate_user!

  def index
    @orders = current_user.orders.order(created_at: :desc)
  end

  def show
    @order = current_user.orders.find(params[:id])
  end

  def new
    if session[:cart].blank?
      redirect_to cart_path, alert: "Your cart is empty."
      return
    end
    @cart = session[:cart]
    @variants = ProductVariant.includes(:product).where(id: @cart.keys)
    @order = Order.new
  end

  def create
    if session[:cart].blank?
      redirect_to cart_path, alert: "Your cart is empty."
      return
    end

    @cart = session[:cart]
    @variants = ProductVariant.includes(:product).where(id: @cart.keys)

    @order = Order.new(order_params)
    @order.user = current_user
    @order.order_number = "HC-#{SecureRandom.hex(4).upcase}"
    @order.status = :pending

    total = 0
    @variants.each do |variant|
      quantity = @cart[variant.id.to_s]
      total += variant.price * quantity
    end
    @order.total_amount = total.to_i

    if @order.save
      @variants.each do |variant|
        quantity = @cart[variant.id.to_s]
        @order.order_items.create!(
          product_variant: variant,
          sku: variant.sku,
          product_name: variant.product.name,
          size: variant.size,
          quantity: quantity,
          unit_price: variant.price.to_i,
          total_price: (variant.price * quantity).to_i
        )
      end
      session[:cart] = {}
      redirect_to @order, notice: "Order placed successfully!"
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def order_params
    params.require(:order).permit(
      :user_id,
      :order_number,
      :status,
      :total_amount,
      :shipping_name,
      :shipping_address,
      :shipping_city,
      :shipping_phone,
      :payment_reference,
      :payment_status
    )
  end
end

class OrdersController < ApplicationController
  before_action :authenticate_user!, only: [:index]

  def index
    @orders = current_user.orders.order(created_at: :desc)
  end

  def show
    if current_user
      @order = current_user.orders.includes(:coupon).find(params[:id])
    else
      @order = Order.includes(:coupon).find(params[:id])
    end
  end

  def new
    @cart = current_cart
    @cart_items = @cart.cart_items.includes(product_variant: :product)
    
    if @cart_items.empty?
      redirect_to cart_path, alert: "Your cart is empty."
      return
    end
    
    @order = Order.new
  end

  def create
    cart = current_cart
    if cart.cart_items.empty?
      redirect_to cart_path, alert: "Your cart is empty."
      return
    end

    @cart = cart
    @cart_items = @cart.cart_items
    @order = Order.new(order_params)
    @order.user = current_user if current_user
    @order.order_number = "HC-#{SecureRandom.hex(4).upcase}"
    @order.status = :pending
    @order.coupon = find_coupon_from_params

    if @order.save
      ActiveRecord::Base.transaction do
        total = 0
        @cart_items.each do |item|
          variant = item.product_variant
          quantity = item.quantity
          total += variant.price * quantity
          @order.order_items.create!(
            product_variant: variant,
            sku: variant.sku,
            product_name: variant.product.name,
            size: variant.size,
            quantity: quantity,
            unit_price: variant.price.to_i,
            total_price: (variant.price * quantity).to_i
          )
          variant.decrement!(:stock, quantity)
        end

        if @order.coupon.present?
          total = apply_discount(@order.coupon, total)
          CouponUsage.create!(coupon: @order.coupon, user: current_user)
        end

        @order.update!(total_amount: total.to_i)
        current_cart.cart_items.destroy_all
      end
      redirect_to @order, notice: "Order placed successfully!"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def track
    if params[:order_number].present?
      @order = Order.find_by(order_number: params[:order_number].upcase.strip)
    end
  end

  private

  def find_coupon_from_params
    return unless params[:order] && params[:order][:coupon_code].present?
    coupon = Coupon.find_by(code: params[:order][:coupon_code].strip.upcase)
    coupon if coupon&.valid_for?(current_user)
  end

  def apply_discount(coupon, total)
    coupon.discount_type == "percentage" ? total - (total * coupon.discount_value / 100) : total - coupon.discount_value
  end

  def order_params
    params.require(:order).permit(
      :user_id,
      :order_number,
      :status,
      :total_amount,
      :shipping_name,
      :shipping_email,
      :shipping_address,
      :shipping_city,
      :shipping_phone,
      :payment_reference,
      :payment_status,
      :coupon_id
    )
  end
end

class Admin::OrdersController < Admin::ApplicationController
  before_action :set_order, only:%i[update]

  def index
    @orders = Order.includes(:user).order(created_at: :desc)
  end

  def show
    @order = Order.includes(:coupon).find(params[:id])
  end

  def update
    if @order.update(order_params)
      redirect_to admin_orders_path, notice: "Order status updated successfully."
    else
      redirect_to admin_orders_path, alert: "Failed to update order status."
    end
  end

  private

  def set_order
    @order = Order.find(params[:id])
  end

  def order_params
    params.require(:order).permit(:status)
  end
end

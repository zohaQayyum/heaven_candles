class OrderMailer < ApplicationMailer
  def confirmation_email(order)
    @order = order
    mail(to: @order.user&.email || @order.shipping_email,
     subject: "Order Received — #{@order.order_number} 🕯️")
  end

  def status_update_email(order)
    @order = order
    mail(
      to: @order.user&.email || @order.shipping_email,
      subject: "Order Update — #{@order.order_number} is now #{@order.status.capitalize} 🕯️"
    )
  end
end

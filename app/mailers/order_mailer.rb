class OrderMailer < ApplicationMailer
  def confirmation_email(order)
    @order = order
    mail(to: @order.user&.email || @order.shipping_email,
     subject: subject: "Order Received — #{@order.order_number} 🕯️")
  end
end

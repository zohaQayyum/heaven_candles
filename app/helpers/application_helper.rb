module ApplicationHelper
  def cart_count
    current_cart.cart_items.sum(:quantity)
  end
end

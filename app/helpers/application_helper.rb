module ApplicationHelper
  def cart_count
    return 0 unless session[:cart]
    session[:cart].values.sum
  end
end

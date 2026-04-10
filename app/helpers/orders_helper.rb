module OrdersHelper
  def order_status_badge_class(status)
    case status
    when "pending"    then "bg-warning text-dark"
    when "processing" then "bg-primary"
    when "shipped"    then "bg-info"
    when "delivered"  then "bg-success"
    when "cancelled"  then "bg-danger"
    end
  end
end

module ApplicationHelper
  def cart_count
    current_cart.cart_items.sum(:quantity)
  end

  def star_rating(rating)
    full_stars = rating.floor
    half_star = (rating - full_stars) >= 0.3 ? 1 : 0
    empty_stars = 5 - full_stars - half_star

    stars = ""
    full_stars.times { stars += '<i class="fas fa-star text-warning"></i>' }
    half_star.times { stars += '<i class="fas fa-star-half-alt text-warning"></i>' }
    empty_stars.times { stars += '<i class="far fa-star text-warning"></i>' }
    stars.html_safe
  end
end

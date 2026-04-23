class Admin::ReviewsController < Admin::ApplicationController
  def index
    @reviews = Review.includes(:user, :product).all.page(params[:page]).per(10)
  end

  def update
    @review = Review.find(params[:id])
    @review.update(status: params[:status])
    redirect_to admin_reviews_path, notice: "Review #{params[:status]}."
  end
end

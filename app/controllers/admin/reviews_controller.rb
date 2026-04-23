class Admin::ReviewsController < Admin::ApplicationController
  before_action :set_review, only:%i[show update]

  def index
    @reviews = Review.includes(:user, :product)
    @reviews = @reviews.where(product_id: params[:product_id]) if params[:product_id].present?
    @reviews = @reviews.all.page(params[:page]).per(10)
  end

  def show
  end

  def update
    @review.update(status: params[:status])
    redirect_to admin_reviews_path, notice: "Review #{params[:status]}."
  end

  private

  def set_review
    @review = Review.find(params[:id])
  end
end

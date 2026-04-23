class ReviewsController < ApplicationController
  def create
    @product = Product.find(params[:product_id])
    @review = @product.reviews.new(review_params)
    @review.user = current_user if current_user

    if @review.save
      redirect_to product_path(@product), notice: 'Review submitted and pending approval.'
    else
      redirect_to product_path(@product), alert: 'Could not submit review. Please check your input.'
    end
  end

  private

  def review_params
    params.require(:review).permit(
      :rating,
      :comment,
      :guest_email,
      :guest_name
    )
  end
end

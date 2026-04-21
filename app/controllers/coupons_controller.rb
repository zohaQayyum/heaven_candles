class CouponsController < ApplicationController
  def apply
    coupon = Coupon.find_by(code: params[:code]&.strip&.upcase)

    return render json: { status: 'error', message: 'Invalid coupon code.' }, status: :not_found unless coupon
    return render json: { status: 'error', message: 'Coupon is expired, inactive, or already used.' }, status: :unprocessable_entity unless coupon.valid_for?(current_user)

    render json: {
      status: 'success',
      message: 'Coupon applied successfully!',
      discount_type: coupon.discount_type,
      discount_value: coupon.discount_value
    }
  end
end

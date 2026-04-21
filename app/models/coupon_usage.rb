class CouponUsage < ApplicationRecord
  belongs_to :coupon
  belongs_to :user, optional: true
end

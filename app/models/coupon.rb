class Coupon < ApplicationRecord
  has_many :coupon_usages, dependent: :destroy
  has_many :orders

  validates :discount_value, numericality: { greater_than: 0 } 
  validates :code, uniqueness: true

  enum discount_type:{
    percentage: 0,
    fixed: 1
  }

  def valid_for?(user_or_session)
    return false unless active
    return false if expired?
    return false if already_used_by?(user_or_session)
    true
  end

  private

  def expired?
    expires_at.present? && expires_at < Time.current
  end

  def already_used_by?(user_or_session)
    coupon_usages.exists?(user: user_or_session)
  end
end

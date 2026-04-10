class Order < ApplicationRecord
  belongs_to :user, optional: true
  has_many :order_items, dependent: :destroy

  validates :total_amount, presence: true, numericality: { greater_than_or_equal_to: 0 }

  validates :shipping_name, :shipping_address, :shipping_city, :shipping_phone, presence: true

  delegate :name, :email, to: :user, prefix: true, allow_nil: true

  validate :valid_status_transition, if: :status_changed?

  enum status: {
    pending: 0,
    processing: 1,
    shipped: 2,
    delivered: 3,
    cancelled: 4
  }

  enum payment_status: {
  unpaid: 0,
  paid: 1,
  refunded: 2
  }, _prefix: true

  ALLOWED_TRANSITIONS = {
    "pending"    => ["processing", "cancelled"],
    "processing" => ["shipped", "cancelled"],
    "shipped"    => ["delivered"],
    "delivered"  => [],
    "cancelled"  => []
  }.freeze

  private

  def valid_status_transition
    unless ALLOWED_TRANSITIONS[status_was]&.include?(status)
      errors.add(:status, "cannot transition from #{status_was} to #{status}")
    end
  end
end

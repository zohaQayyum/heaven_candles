class Order < ApplicationRecord
  belongs_to :user, optional: true
  has_many :order_items, dependent: :destroy

  validates :total_amount, presence: true, numericality: { greater_than_or_equal_to: 0 }

  validates :shipping_name, :shipping_address, :shipping_city, :shipping_phone, presence: true

  enum status: {
  pending: 0,
  paid: 1,
  failed: 2,
  shipped: 3,
  cancelled: 4
  }

  enum payment_status: {
  unpaid: 0,
  paid: 1,
  refunded: 2
  }, _prefix: true
end

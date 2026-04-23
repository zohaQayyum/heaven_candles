class Review < ApplicationRecord
  belongs_to :product
  belongs_to :user, optional: true

  enum status: { pending: 0, approved: 1, rejected: 2 }

  validates :rating, presence: true, inclusion: { in: 1..5 }
  validates :comment, presence: true
  validates :user_id, uniqueness: { scope: :product_id }, allow_nil: true
end

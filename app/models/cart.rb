class Cart < ApplicationRecord
  belongs_to :user
  has_many :cart_items, dependent: :destroy

  enum status: { active: 0, converted: 1 }

  def total_amount
    cart_items.sum("quantity * unit_price")
  end
end

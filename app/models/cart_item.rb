class CartItem < ApplicationRecord
  belongs_to :cart
  belongs_to :product_variant

  validates :quantity, numericality: { greater_than: 0 }

  before_validation :set_unit_price, on: :create

  private

  def set_unit_price
    self.unit_price ||= product_variant.price
  end
end

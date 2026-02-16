class ProductVariant < ApplicationRecord
  belongs_to :product

  enum size: { small: 0, medium: 1, large: 2 }

  validates :price, presence: true, numericality: { greater_than: 0 }
  validates :stock, numericality: { greater_than_or_equal_to: 0 }
end

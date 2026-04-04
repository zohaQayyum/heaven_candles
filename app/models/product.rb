class Product < ApplicationRecord
  belongs_to :category
  has_many :product_variants, dependent: :destroy

  validates :name, presence: true

  delegate :name, to: :category, prefix: true, allow_nil: true

  def starting_price
    product_variants.minimum(:price)
  end
end

class Product < ApplicationRecord
  include PgSearch::Model
  
  has_many_attached :images
  belongs_to :category
  has_many :product_variants, dependent: :destroy

  validates :name, presence: true

  delegate :name, to: :category, prefix: true, allow_nil: true

  pg_search_scope :search_by_name_and_description,
    against: [:name, :description],
    using: {
      tsearch: { prefix: true },
      trigram: { only: [:name] }
    }

  def starting_price
    product_variants.minimum(:price)
  end
end

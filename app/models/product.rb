class Product < ApplicationRecord
  include PgSearch::Model
  
  has_many_attached :images
  belongs_to :category
  has_many :product_variants, dependent: :destroy
  has_many :reviews, dependent: :destroy

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

  def average_rating
    reviews.approved.average(:rating)&.round(1)
  end
end

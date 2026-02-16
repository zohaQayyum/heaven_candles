class Product < ApplicationRecord
  belongs_to :category
  has_many :product_variants, dependent: :destroy

  validates :name, presence: true
end

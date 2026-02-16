require 'rails_helper'

RSpec.describe Product, type: :model do
  it { should belong_to(:category) }
  it { should have_many(:product_variants).dependent(:destroy) }
  it { should validate_presence_of(:name) }
end

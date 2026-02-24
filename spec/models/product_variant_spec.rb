require 'rails_helper'

RSpec.describe ProductVariant, type: :model do
  subject { create(:product_variant) }

  describe 'associations' do
    it { should belong_to(:product).required }
  end

  describe 'validations' do
    it { should validate_presence_of(:price) }
    it { should validate_presence_of(:stock) }
    it { should validate_presence_of(:sku) }
    it { should validate_numericality_of(:price).is_greater_than(0) }
    it { should validate_numericality_of(:stock).is_greater_than_or_equal_to(0).only_integer }
    it { should validate_uniqueness_of(:sku) }

    describe 'size uniqueness per product' do
      let(:product) { create(:product) }

      it 'does not allow duplicate size for same product' do
        create(:product_variant, product: product, size: :small)

        duplicate = build(:product_variant, product: product, size: :small)

        expect(duplicate).not_to be_valid
        expect(duplicate.errors[:size]).to include("has already been taken")
      end

      it 'allows same size for different products' do
        product2 = create(:product)

        create(:product_variant, product: product, size: :small)

        variant = build(:product_variant, product: product2, size: :small)

        expect(variant).to be_valid
      end
    end
  end

  describe 'enums' do
    it do
      should define_enum_for(:size)
        .with_values(small: 0, medium: 1, large: 2)
    end
  end

  describe 'custom validations' do
    it 'is invalid when stock is negative' do
      variant = build(:product_variant, stock: -1)
      expect(variant).not_to be_valid
    end

    it 'is invalid when price is zero' do
      variant = build(:product_variant, price: 0)
      expect(variant).not_to be_valid
    end
  end
end

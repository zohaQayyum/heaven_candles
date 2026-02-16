RSpec.describe ProductVariant, type: :model do
  describe 'associations' do
    it { should belong_to(:product) }
  end

  describe 'validations' do
    it { should validate_presence_of(:price) }
    it { should validate_numericality_of(:price).is_greater_than(0) }
    it { should validate_numericality_of(:stock).is_greater_than_or_equal_to(0) }
  end

  describe 'enums' do
    it { should define_enum_for(:size).with_values(small: 0, medium: 1, large: 2) }
  end
end

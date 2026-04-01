require 'rails_helper'

RSpec.describe CartItem, type: :model do
  it { should belong_to(:cart) }
  it { should belong_to(:product_variant) }

  it { should validate_numericality_of(:quantity).is_greater_than(0) }

  it "sets unit_price from product_variant on create" do
    cart = create(:cart)
    variant = create(:product_variant, price: 300)

    cart_item = create(:cart_item, cart: cart, product_variant: variant)

    expect(cart_item.unit_price).to eq(300)
  end
end

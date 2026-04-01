require 'rails_helper'

RSpec.describe Cart, type: :model do
  let!(:cart) { create(:cart) }

  it { should belong_to(:user) }
  it { should have_many(:cart_items).dependent(:destroy) }

  it "calculates total_amount correctly" do
    create(:cart_item, cart: cart, quantity: 2, unit_price: 100)
    create(:cart_item, cart: cart, quantity: 1, unit_price: 50)

    expect(cart.reload.total_amount).to eq(250)
  end
end

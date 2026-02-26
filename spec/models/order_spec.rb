require 'rails_helper'

RSpec.describe Order, type: :model do
  it { should belong_to(:user).optional }
  it { should have_many(:order_items).dependent(:destroy) }
  it { should validate_numericality_of(:total_amount) }

  describe 'enums' do
    it do
      should define_enum_for(:status)
      .with_values(
        pending: 0,
        paid: 1,
        failed: 2,
        shipped: 3,
        cancelled: 4
      )
    end

    it do
      should define_enum_for(:payment_status)
      .with_values(
        unpaid: 0,
        paid: 1,
        refunded: 2
      ).with_prefix(true)
    end
  end
end

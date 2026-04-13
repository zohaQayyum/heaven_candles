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
        processing: 1,
        shipped: 2,
        delivered: 3,
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

  describe 'status transitions' do
    context 'valid transitions' do
      [
        [:pending, :processing],
        [:pending, :cancelled],
        [:processing, :shipped],
        [:processing, :cancelled],
        [:shipped, :delivered]
      ].each do |from, to|
        it "allows #{from} to #{to}" do
          order = create(:order)
          order.update_column(:status, Order.statuses[from])
          expect(order.update(status: to)).to be true
        end
      end
    end

    context 'invalid transitions' do
      [
        [:pending, :delivered],
        [:pending, :shipped],
        [:processing, :pending],
        [:shipped, :pending],
        [:delivered, :processing],
        [:cancelled, :pending]
      ].each do |from, to|
        it "does not allow #{from} to #{to}" do
          order = create(:order)
          order.update_column(:status, Order.statuses[from])
          expect(order.update(status: to)).to be false
          expect(order.errors[:status]).to be_present
        end
      end
    end
  end
end

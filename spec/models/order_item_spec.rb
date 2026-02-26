require 'rails_helper'

RSpec.describe OrderItem, type: :model do
  it { should belong_to(:order) }
  it { should belong_to(:product_variant) }

  it { should validate_presence_of(:sku) }
  it { should validate_presence_of(:product_name) }
end

require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:email) }
  end

  describe 'enums' do
    it { should define_enum_for(:role).with_values(customer: 0, admin: 1) }
  end
end

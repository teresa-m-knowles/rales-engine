require 'rails_helper'

RSpec.describe Merchant, type: :model do
  describe 'validations' do
    it {should validate_presence_of :name}
    it {should validate_length_of(:name)
      .is_at_least(1)}
  end

  describe 'relationships' do
    it {should have_many :items}
    it {should have_many :invoices}
  end
end

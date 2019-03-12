require 'rails_helper'

RSpec.describe Invoice, type: :model do
  describe 'validations' do
    it {should validate_presence_of :status}
    it {should validate_presence_of :created_at}
    it {should validate_presence_of :updated_at}
  end
  describe 'relationships' do
    it {should belong_to :customer}
    it {should belong_to :merchant}
  end
end

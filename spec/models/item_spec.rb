require 'rails_helper'

RSpec.describe Item, type: :model do
  describe 'validations' do
    it {should validate_presence_of :name}
    it {should validate_presence_of :description}
    it {should validate_presence_of :unit_price}
    it {should validate_presence_of :created_at}
    it {should validate_presence_of :updated_at}
  end

  describe 'relationships' do
    it {should have_many :invoice_items}
    it {should belong_to :merchant}
    it {should have_many :invoices}
  end

  describe 'class methods' do
    describe 'returns the top items ranked by total revenue generated' do
      it 'top_revenue' do
        merchant = create(:merchant)
        customer = create(:customer)
        item_1 = create(:item, merchant: merchant, unit_price: 10)
        item_2 = create(:item, merchant: merchant, unit_price: 20)
        item_3 = create(:item, merchant: merchant, unit_price: 5)
        invoice_1 = create(:invoice, customer: customer, merchant: merchant)
        create(:transaction, result: 'success', invoice: invoice_1)
        invoice_2 = create(:invoice, customer: customer, merchant: merchant)
        create(:transaction, result: 'success', invoice: invoice_2)

        invoice_3 = create(:invoice, customer: customer, merchant: merchant)
        create(:transaction, result: 'success', invoice: invoice_3)

        invoice_item_1 = create(:invoice_item, item: item_1, invoice: invoice_1, quantity: 10)
        invoice_item_2 = create(:invoice_item, item: item_2, invoice: invoice_1, quantity: 4)
        invoice_item_3 = create(:invoice_item, item: item_3, invoice: invoice_1, quantity: 5)

        expect(Item.top_revenue(2).first).to eq(item_1)
        expect(Item.top_revenue(2).second).to eq(item_2)
      end
    end

    describe 'returns the top items ranked by total number sold' do
      it 'top_selling' do
        merchant = create(:merchant)
        customer = create(:customer)
        item_1 = create(:item, merchant: merchant, unit_price: 10)
        item_2 = create(:item, merchant: merchant, unit_price: 20)
        item_3 = create(:item, merchant: merchant, unit_price: 5)
        invoice_1 = create(:invoice, customer: customer, merchant: merchant)
        create(:transaction, result: 'success', invoice: invoice_1)
        invoice_2 = create(:invoice, customer: customer, merchant: merchant)
        create(:transaction, result: 'success', invoice: invoice_2)

        invoice_3 = create(:invoice, customer: customer, merchant: merchant)
        create(:transaction, result: 'success', invoice: invoice_3)

        invoice_item_1 = create(:invoice_item, item: item_1, invoice: invoice_1, quantity: 10)
        invoice_item_2 = create(:invoice_item, item: item_2, invoice: invoice_1, quantity: 7)
        invoice_item_3 = create(:invoice_item, item: item_3, invoice: invoice_1, quantity: 5)

        expect(Item.top_selling(2).first).to eq(item_1)
        expect(Item.top_selling(2).second).to eq(item_2)
      end
    end
  end
end

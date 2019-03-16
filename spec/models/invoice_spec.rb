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

  describe 'Class methods' do
    describe 'it returns the total revenue for a given date across all merchants' do
      it 'total_revenue' do
        date_wanted = '2012-03-25 09:54:09 UTC'
        unwanted_date = '2012-03-30 09:54:09 UTC'
        merchant_1 = create(:merchant)
        merchant_2 = create(:merchant)

        customer = create(:customer)

        #From merchant 1
        #Revenue is 15.23
        item_1 = create(:item, merchant: merchant_1, unit_price: 15.23)
        invoice_1 = create(:invoice, customer: customer, merchant: merchant_1, created_at: date_wanted)
        invoice_item_1 = create(:invoice_item, item: item_1, invoice: invoice_1, quantity: 1)
        transaction_1 = create(:transaction, invoice: invoice_1, result: 'success')

        #------------------------------------------------------
        #From merchant 2, revenue is $10
        item_2 = create(:item, merchant: merchant_2, unit_price: 10)
        invoice_2 = create(:invoice, customer: customer, merchant: merchant_2, created_at: date_wanted)
        invoice_item_2 = create(:invoice_item, item: item_2, invoice: invoice_2, quantity: 1)
        transaction_2 = create(:transaction, invoice: invoice_2, result: 'success')
        #Total for wanted date should be $25.23
        #-------------------------------------------------
        #From merchant 1, unwanted date:revenue is $20
        invoice_3 = create(:invoice, customer: customer, merchant: merchant_1, created_at: unwanted_date)
        invoice_item_3 = create(:invoice_item, item: item_1, invoice: invoice_3, quantity: 1)
        transaction_3 = create(:transaction, invoice: invoice_3, result: 'success')
        #-----------------------------------------

        expect(Invoice.total_revenue(date_wanted)).to eq(25.23)
      end
    end
  end
end

require 'rails_helper'

RSpec.describe Customer, type: :model do
  describe 'validations' do
    it {should validate_presence_of :first_name}
    it {should validate_presence_of :last_name}
    it {should validate_presence_of :created_at}
    it {should validate_presence_of :updated_at}
  end

  describe 'relationships' do
    it {should have_many :invoices}
  end

  describe 'class methods' do
    describe 'it returns the favorite customer, which is the customer who has conducted the most total number of successful transactions ' do
      it 'favorite_customer' do
        merchant = create(:merchant)
        customer_1 = create(:customer)
        customer_2 = create(:customer)
        #Customer 1 has 3 transactions, customer 2 has 1

        item_1 = create(:item, unit_price: 10, merchant: merchant)
        invoice_1 = create(:invoice, merchant: merchant, customer: customer_1)
        invoice_item_1 = create(:invoice_item, item: item_1, invoice: invoice_1)
        transaction_1 = create(:transaction, invoice: invoice_1, result: 'success')

        invoice_2 = create(:invoice, merchant: merchant, customer: customer_1)
        invoice_item_2 = create(:invoice_item, item: item_1, invoice: invoice_2, quantity: 5)
        transaction_2 = create(:transaction, invoice: invoice_1, result: 'success')

        invoice_3 = create(:invoice, merchant: merchant, customer: customer_1)
        item_2 = create(:item, unit_price: 23, merchant: merchant)
        invoice_item_3 = create(:invoice_item, item: item_1, invoice: invoice_3)
        transaction_3 = create(:transaction, invoice: invoice_1, result: 'success')

        invoice_4 = create(:invoice, merchant: merchant, customer: customer_2)
        invoice_item_3 = create(:invoice_item, item: item_2, invoice: invoice_4, quantity: 1)
        transaction_3 = create(:transaction, invoice: invoice_3, result: 'success')

        expect(Customer.favorite_customer(merchant.id)).to eq(customer_1)

      end
    end
  end

  describe 'instance methods' do
    describe 'returns a merchant where the customer has conducted the most successful transactions' do
      it 'favorite_merchant' do
        customer = create(:customer)
        merchant_1 = create(:merchant)
        merchant_2 = create(:merchant)

        #Customer has 4 invoices from each merchant
        #From merchant 1, 5 transactions. 3 successful and 2 failed
        #From merchant 2, 4 transactions. 2 successful and 2 failed

        #Favorite merchant should be merchant 1


        #From merchant 1, 4 invoices
        invoice_1 = create(:invoice, merchant: merchant_1, customer: customer)
        invoice_2 = create(:invoice, merchant: merchant_1, customer: customer)
        invoice_3 = create(:invoice, merchant: merchant_1, customer: customer)
        invoice_4 = create(:invoice, merchant: merchant_1, customer: customer)

        #From merchant 1, 5 transactions. 3 successful and 2 failed
        transaction_1 = create(:transaction, result: 'success', invoice: invoice_1)
        transaction_2 = create(:transaction, result: 'success', invoice: invoice_2)
        transaction_3 = create(:transaction, result: 'success', invoice: invoice_3)
        transaction_4 = create(:transaction, result: 'failed', invoice: invoice_3)
        transaction_5 = create(:transaction, result: 'failed', invoice: invoice_4)

        #From merchant 2, 4 invoices
        invoice_5 = create(:invoice, merchant: merchant_2, customer: customer)
        invoice_6 = create(:invoice, merchant: merchant_2, customer: customer)
        invoice_7 = create(:invoice, merchant: merchant_2, customer: customer)
        invoice_8 = create(:invoice, merchant: merchant_2, customer: customer)

        #From merchant 2, 4 transactions. 2 successful and 2 failed
        transaction_6 = create(:transaction, result: 'success', invoice: invoice_5)
        transaction_7 = create(:transaction, result: 'success', invoice: invoice_6)
        transaction_8 = create(:transaction, result: 'success', invoice: invoice_7)
        transaction_9 = create(:transaction, result: 'failed', invoice: invoice_8)

        expect(customer.favorite_merchant).to eq(merchant_1)
      end
    end

  end
end

require 'rails_helper'

RSpec.describe 'Single Merchant Business Intelligence' do
  xit 'returns the total revenue for that merchant across successful transactions' do
    merchant_1 = create(:merchant)
    merchant_2 = create(:merchant)
    customer = create(:customer)
    #GET /api/v1/merchants/:id/revenue

    #Invoice from merchant 1
    #Revenue is $100 from 1 successful transaction
    invoice_1 = create(:invoice, merchant: merchant_1, customer: customer)
    item_1 = create(:item, unit_price: 10, merchant: merchant_1)
    invoice_item_1 = create(:invoice_item, item: item_1, invoice: invoice_1, quantity: 10)
    transaction_1 = create(:transaction, invoice: invoice_1, result: 'success')

    invoice_2 = create(:invoice, merchant: merchant_1, customer: customer)
    invoice_item_2 = create(:invoice_item, item: item_1, invoice: invoice_2, quantity: 5)
    transaction_2 = create(:transaction, invoice: invoice_1, result: 'failed')
#-------------------------------------------------------------------------------
    #From merchant 2 revenue is $46
    invoice_3 = create(:invoice, merchant: merchant_2, customer: customer)
    item_2 = create(:item, unit_price: 23, merchant: merchant_2)
    invoice_item_3 = create(:invoice_item, item: item_2, invoice: invoice_3, quantity: 2)
    transaction_3 = create(:transaction, invoice: invoice_3, result: 'success')

    invoice_4 = create(:invoice, merchant: merchant_2, customer: customer)
    invoice_item_3 = create(:invoice_item, item: item_2, invoice: invoice_4, quantity: 1)
    transaction_3 = create(:transaction, invoice: invoice_3, result: 'failed')
    #------------------------------------------------
    binding.pry
    response = JSON.parse(response.body)

  end
end

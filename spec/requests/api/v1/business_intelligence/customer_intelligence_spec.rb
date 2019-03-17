require 'rails_helper'

RSpec.describe 'Customer business intelligence' do
  it 'returns a merchant where the customer has conducted the most successful transactions' do
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

    get "/api/v1/customers/#{customer.id}/favorite_merchant"

    fav_merchant = JSON.parse(response.body)["data"]

    expect(response).to be_successful
    expect(fav_merchant["id"]).to eq(merchant_1.id.to_s)

  end
end

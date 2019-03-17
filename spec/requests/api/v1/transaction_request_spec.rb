require 'rails_helper'

RSpec.describe 'Transaction API' do
  it 'returns all transactions' do
    merchant = create(:merchant)
    customer = create(:customer)
    item = create(:item, merchant: merchant)
    invoice = create(:invoice, customer: customer, merchant: merchant)
    invoice_item = create(:invoice_item, invoice: invoice, item: item)
    transactions = create_list(:transaction, 3, invoice: invoice)

    get "/api/v1/transactions"

    expect(response).to be_successful

    indexed_transactions = JSON.parse(response.body)

    expect(indexed_transactions["data"].count).to eq(3)
    expect(indexed_transactions["data"][0]["id"]).to eq(transactions[0].id.to_s)
    expect(indexed_transactions["data"][1]["id"]).to eq(transactions[1].id.to_s)
    expect(indexed_transactions["data"][2]["id"]).to eq(transactions[2].id.to_s)

  end
end

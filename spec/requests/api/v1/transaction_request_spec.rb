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
  it 'returns a transaction given its id' do
    merchant = create(:merchant)
    customer = create(:customer)
    item = create(:item, merchant: merchant)
    invoice = create(:invoice, customer: customer, merchant: merchant)
    invoice_item = create(:invoice_item, invoice: invoice, item: item)
    transaction= create(:transaction, invoice: invoice)

    get "/api/v1/transactions/#{transaction.id}"
    expect(response).to be_successful

    result = JSON.parse(response.body)

    expect(result["data"]["id"]).to eq(transaction.id.to_s)
  end

  it 'returns associated invoice' do
    merchant = create(:merchant)
    customer = create(:customer)
    item = create(:item, merchant: merchant)
    invoice = create(:invoice, customer: customer, merchant: merchant)
    invoice_item = create(:invoice_item, invoice: invoice, item: item)
    transaction= create(:transaction, invoice: invoice)

    get "/api/v1/transactions/#{transaction.id}/invoice"

    result = JSON.parse(response.body)

    expect(result["data"]["id"]).to eq(invoice.id.to_s)
    expect(result["data"]["type"]).to eq("invoice")
  end

  it 'can find a transaction by using search parameters' do
    merchant = create(:merchant)
    item_1 = create(:item, merchant: merchant)
    item_2 = create(:item, merchant: merchant)
    customer = create(:customer)
    invoice_1 = create(:invoice, customer: customer, merchant: merchant)
    invoice_2 = create(:invoice, customer: customer, merchant: merchant)
    transaction_1 = create(:transaction, result: 'success', invoice: invoice_1, credit_card_number: "4330934842024570")
    transaction_2 = create(:transaction, result: 'failed', invoice: invoice_1)
    transaction_3 = create(:transaction, invoice: invoice_2)

    get "/api/v1/transactions/find?credit_card_number=4330934842024570"

    result = JSON.parse(response.body)

    expect(result["data"]["id"]).to eq(transaction_1.id.to_s)
  end

  it 'can find all transactions that match the search parameters' do
    merchant = create(:merchant)
    item_1 = create(:item, merchant: merchant)
    item_2 = create(:item, merchant: merchant)
    customer = create(:customer)
    invoice_1 = create(:invoice, customer: customer, merchant: merchant)
    invoice_2 = create(:invoice, customer: customer, merchant: merchant)
    transaction_1 = create(:transaction, result: 'failed', invoice: invoice_1, credit_card_number: "4330934842024570")
    transaction_2 = create(:transaction, result: 'success', invoice: invoice_1)
    transaction_3 = create(:transaction, result: 'failed', invoice: invoice_2)

    get "/api/v1/transactions/find_all?result=failed"

    found_transactions = JSON.parse(response.body)

    expect(found_transactions["data"].count).to eq(2)
    expect(found_transactions["data"][0]["id"]).to eq(transaction_1.id.to_s)
    expect(found_transactions["data"][1]["id"]).to eq(transaction_3.id.to_s)
  end

  it 'can get a random transaction ' do
    merchant = create(:merchant)
    item_1 = create(:item, merchant: merchant)
    item_2 = create(:item, merchant: merchant)
    customer = create(:customer)
    invoice_1 = create(:invoice, customer: customer, merchant: merchant)
    invoice_2 = create(:invoice, customer: customer, merchant: merchant)
    transaction_1 = create(:transaction, result: 'failed', invoice: invoice_1, credit_card_number: "4330934842024570")
    transaction_2 = create(:transaction, result: 'failed', invoice: invoice_1)
    transaction_3 = create(:transaction, result: 'failed', invoice: invoice_2)

    get "/api/v1/transactions/random"

    transaction = JSON.parse(response.body)

    expect(transaction["data"]["type"]).to eq('transaction')
  end
end

require 'rails_helper'

RSpec.describe 'Customers API' do
  it 'returns all customers' do
    customers = create_list(:customer, 3)

    get "/api/v1/customers"

    expect(response).to be_successful

    result = JSON.parse(response.body)

    expect(result["data"].count).to eq(3)
  end

  it 'shows one customer' do
    customer = create(:customer)

    get "/api/v1/customers/#{customer.id}"
    expect(response).to be_successful

    found_customer = JSON.parse(response.body)

    expect(found_customer["data"]["id"]).to eq(customer.id.to_s)
  end

  describe 'relationships' do
    it 'returns a collection of associated invoices' do
      merchant_1 = create(:merchant)
      merchant_2 = create(:merchant)
      customer = create(:customer)
      invoice_1 = create(:invoice, customer: customer, merchant: merchant_1)
      invoice_2 = create(:invoice, customer: customer, merchant: merchant_1)
      invoice_3 = create(:invoice, customer: customer, merchant: merchant_2)

      get "/api/v1/customers/#{customer.id}/invoices"

      result = JSON.parse(response.body)
      expect(result["data"].count).to eq(3)
      expect(result["data"][0]["id"]).to eq(invoice_1.id.to_s)
      expect(result["data"][1]["id"]).to eq(invoice_2.id.to_s)
      expect(result["data"][2]["id"]).to eq(invoice_3.id.to_s)

    end

    it 'returns a collection of associated transactions' do
      merchant_1 = create(:merchant)
      customer = create(:customer)
      invoice = create(:invoice, customer: customer, merchant: merchant_1)
      transaction_1 = create(:transaction, invoice: invoice, result: 'success')
      transaction_2 = create(:transaction, invoice: invoice, result: 'failed')

      get "/api/v1/customers/#{customer.id}/transactions"

      result = JSON.parse(response.body)

      expect(result["data"].count).to eq(2)
      expect(result["data"][0]["id"]).to eq(transaction_1.id.to_s)
      expect(result["data"][1]["id"]).to eq(transaction_2.id.to_s)
    end
  end
end

require 'rails_helper'

RSpec.describe 'Customers API' do
  describe 'record endpoints' do
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
  end

  describe 'finders' do
    it 'can return a customer by searching by any of its parameters' do
      customer = create(:customer, first_name: "John", last_name: "Wick", created_at: "2012-03-27T14:56:04.000Z", updated_at: "2012-03-27T14:56:04.000Z")

      get "/api/v1/customers/find?first_name=#{customer.first_name}"

      expect(response).to be_successful

      wick = JSON.parse(response.body)

      expect(wick["data"]["id"]).to eq(customer.id.to_s)
    end

    it 'can return all customers that match the search parameter' do
      customer_1 = create(:customer, first_name: "John", last_name: "Thompson")
      customer_2 = create(:customer, first_name: "John", last_name: "Smith")
      customer_3 = create(:customer, first_name: "Frank", last_name: "Smith")

      get "/api/v1/customers/find_all?first_name=John"

      expect(response).to be_successful

      results = JSON.parse(response.body)

      expect(results["data"].count).to eq(2)
    end
  end

  describe 'returns a random customer' do
    it 'random customer' do
      customer_1 = create(:customer, first_name: "John", last_name: "Thompson")
      customer_2 = create(:customer, first_name: "John", last_name: "Smith")
      customer_3 = create(:customer, first_name: "Frank", last_name: "Smith")

      get "/api/v1/customers/random"

      result = JSON.parse(response.body)
      expect(result["data"]["type"]).to eq("customer")
      expect(result.count).to eq(1)
    end
  end



  describe 'relationship endpoints' do
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

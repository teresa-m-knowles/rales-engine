require 'rails_helper'

describe 'Invoices API' do
  it 'shows a list of all invoices' do
    customer = create(:customer)
    merchant = create(:merchant)

    invoice_1 = create(:invoice, customer: customer, merchant: merchant)
    invoice_2 = create(:invoice, customer: customer, merchant: merchant)
    invoice_3 = create(:invoice, customer: customer, merchant: merchant)

    get "/api/v1/invoices.json"

    invoices = JSON.parse(response.body)

    expect(response).to be_successful
    expect(invoices["data"].count).to eq(3)
  end

  it 'shows an invoices if given their id ' do
    customer = create(:customer)
    merchant = create(:merchant)
    id = create(:invoice, customer: customer, merchant: merchant).id

    get "/api/v1/invoices/#{id}"

    expect(response).to be_successful
    invoice = JSON.parse(response.body)["data"]
    expect(invoice["id"]).to eq(id.to_s)
  end

  describe 'single finders' do
    it 'can find an invoice by its attributes' do
      customer_1 = create(:customer)
      customer_2 = create(:customer)
      merchant = create(:merchant)

      invoice_1 = create(:invoice, customer: customer_1, merchant: merchant)
      invoice_2 = create(:invoice, customer: customer_2, merchant: merchant)
      invoice_3 = create(:invoice, customer: customer_2, merchant: merchant)

      get "/api/v1/invoices/find?customer_id=#{customer_1.id}"

      expect(response).to be_successful

      invoice = JSON.parse(response.body)["data"]

      expect(invoice["attributes"]["id"]).to eq(invoice_1.id)
    end
  end

  describe 'multi finders' do
    it 'returns all invoices that match the search parameter' do
      customer_1 = create(:customer)
      customer_2 = create(:customer)
      merchant = create(:merchant)

      invoice_1 = create(:invoice, customer: customer_1, merchant: merchant)
      invoice_2 = create(:invoice, customer: customer_2, merchant: merchant)
      invoice_3 = create(:invoice, customer: customer_2, merchant: merchant)

      get "/api/v1/invoices/find_all?customer_id=#{customer_2.id}"

      expect(response).to be_successful

      invoices = JSON.parse(response.body)["data"]

      expect(invoices.count).to eq(2)
      expect(invoices.first["attributes"]["id"]).to eq(invoice_2.id)
      expect(invoices.second["attributes"]["id"]).to eq(invoice_3.id)

    end
  end

  describe 'random' do
    it 'returns a random invoice' do
      customer_1 = create(:customer)
      customer_2 = create(:customer)
      merchant = create(:merchant)

      invoice_1 = create(:invoice, customer: customer_1, merchant: merchant)
      invoice_2 = create(:invoice, customer: customer_2, merchant: merchant)
      invoice_3 = create(:invoice, customer: customer_2, merchant: merchant)

      get "/api/v1/invoices/random"

      invoice = JSON.parse(response.body)

      expect(response).to be_successful

      expect(invoice["data"]["type"]).to eq("invoice")
    end
  end

  describe 'relationship endpoints' do
    it 'invoices/:id/transactions returns that invoice transactions' do
      customer = create(:customer)
      merchant = create(:merchant)
      invoice = create(:invoice, customer: customer, merchant: merchant)
      invoice_2 = create(:invoice, customer: customer, merchant: merchant)
      transaction_1 = create(:transaction, invoice: invoice)
      transaction_2 = create(:transaction, invoice: invoice)
      transaction_3 = create(:transaction, invoice: invoice)
      transaction_4 = create(:transaction, invoice: invoice_2)

      get "/api/v1/invoices/#{invoice.id}/transactions"

      expect(response).to be_successful

      transactions = JSON.parse(response.body)

      expect(transactions["data"].count).to eq(3)
      expect(transactions["data"].first["id"]).to eq(transaction_1.id.to_s)
      expect(transactions["data"].second["id"]).to eq(transaction_2.id.to_s)
      expect(transactions["data"].third["id"]).to eq(transaction_3.id.to_s)
    end

  end
end

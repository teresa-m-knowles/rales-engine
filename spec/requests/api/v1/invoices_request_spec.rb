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
    id = create(:invoice, customer: customer, merchant: merchant)

    get "/api/v1/invoices/#{id}"

    expect(response).to be_successful
    invoice = JSON.parse(response.body)["data"]
    expect(invoice["id"]).to eq(id.to_s)
  end
end

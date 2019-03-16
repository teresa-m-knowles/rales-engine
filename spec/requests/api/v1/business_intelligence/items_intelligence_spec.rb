require 'rails_helper'

RSpec.describe 'Items business intelligence' do
  it 'returns the top x items ranked by total revenue generated' do
    merchant = create(:merchant)
    customer = create(:customer)
    item_1 = create(:item, merchant: merchant, unit_price: 10)
    item_2 = create(:item, merchant: merchant, unit_price: 20)
    item_3 = create(:item, merchant: merchant, unit_price: 5)
    invoice_1 = create(:invoice, customer: customer, merchant: merchant)
    create(:transaction, result: 'success', invoice: invoice_1)
    invoice_2 = create(:invoice, customer: customer, merchant: merchant)
    create(:transaction, result: 'success', invoice: invoice_2)

    invoice_3 = create(:invoice, customer: customer, merchant: merchant)
    create(:transaction, result: 'success', invoice: invoice_3)

    invoice_item_1 = create(:invoice_item, item: item_1, invoice: invoice_1, quantity: 10)
    invoice_item_2 = create(:invoice_item, item: item_2, invoice: invoice_1, quantity: 4)
    invoice_item_3 = create(:invoice_item, item: item_3, invoice: invoice_1, quantity: 5)

    get '/api/v1/items/most_revenue?quantity=2'

    two_items = JSON.parse(response.body)["data"]
    expect(response).to be_successful

    expect(two_items.first["attributes"]["id"]).to eq(item_1.id)
    expect(two_items.second["attributes"]["id"]).to eq(item_2.id)

  end

  it 'returns the top x items ranked by total items sold' do
    merchant = create(:merchant)
    customer = create(:customer)
    item_1 = create(:item, merchant: merchant, unit_price: 10)
    item_2 = create(:item, merchant: merchant, unit_price: 20)
    item_3 = create(:item, merchant: merchant, unit_price: 5)
    invoice_1 = create(:invoice, customer: customer, merchant: merchant)
    create(:transaction, result: 'success', invoice: invoice_1)
    invoice_2 = create(:invoice, customer: customer, merchant: merchant)
    create(:transaction, result: 'success', invoice: invoice_2)

    invoice_3 = create(:invoice, customer: customer, merchant: merchant)
    create(:transaction, result: 'success', invoice: invoice_3)

    invoice_item_1 = create(:invoice_item, item: item_1, invoice: invoice_1, quantity: 10)
    invoice_item_2 = create(:invoice_item, item: item_2, invoice: invoice_1, quantity: 7)
    invoice_item_3 = create(:invoice_item, item: item_3, invoice: invoice_1, quantity: 5)

    get "/api/v1/items/most_items?quantity=2"

    two_items = JSON.parse(response.body)["data"]
    expect(response).to be_successful

    expect(two_items.first["attributes"]["id"]).to eq(item_1.id)
    expect(two_items.second["attributes"]["id"]).to eq(item_2.id)
  end

  it ' returns the date with the most sales for the given item using the invoice date. If there are multiple days with equal number of sales, return the most recent day.' do
    merchant = create(:merchant)
    customer = create(:customer)

    date = '2012-03-23T10:55:29.000Z'

    item = create(:item, merchant: merchant)

    invoice_1 = create(:invoice, customer: customer, merchant: merchant, created_at: '2012-03-23T10:55:29.000Z')
    invoice_item_1 = create(:invoice_item, item: item, invoice: invoice_1)
    transaction_1 = create(:transaction, result: 'success', invoice: invoice_1)

    invoice_2 = create(:invoice, customer: customer, merchant: merchant, created_at: '2012-03-23T10:55:29.000Z')
    invoice_item_2 = create(:invoice_item, item: item, invoice: invoice_2)
    transaction_2 = create(:transaction, result: 'success', invoice: invoice_2)

    invoice_3 = create(:invoice, customer: customer, merchant: merchant, created_at: '2012-03-24T10:55:29.000Z')
    invoice_item_3 = create(:invoice_item, item: item, invoice: invoice_3)
    transaction_3 = create(:transaction, result: 'success', invoice: invoice_3)

    get "/api/v1/items/#{item.id}/best_day"

    date = JSON.parse(response.body)["data"]["attributes"]["best_day"]

    expect(date).to eq('2012-03-23T10:55:29.000Z')



  end
end

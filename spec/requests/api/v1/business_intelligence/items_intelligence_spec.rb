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

    two_items = JSON.parse(response.body)["data"]["attributes"]

    expect(response).to be_successful


  end
  #GET /api/v1/items/most_revenue?quantity=x
end

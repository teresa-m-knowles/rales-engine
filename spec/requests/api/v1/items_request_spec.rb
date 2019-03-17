require 'rails_helper'

RSpec.describe 'Items API' do
  it 'shows all items' do
    merchant = create(:merchant)
    items = create_list(:item, 3, merchant: merchant)

    get "/api/v1/items"

    expect(response).to be_successful

    indexed_items = JSON.parse(response.body)


    expect(indexed_items["data"].count).to eq(3)
    expect(indexed_items["data"].first["id"]).to eq(items.first.id.to_s)
    expect(indexed_items["data"].second["id"]).to eq(items[1].id.to_s)
    expect(indexed_items["data"].third["id"]).to eq(items[2].id.to_s)
  end

  it 'shows one item' do
    merchant = create(:merchant)
    item = create(:item, merchant: merchant)

    get "/api/v1/items/#{item.id}"

    expect(response).to be_successful

    found_item = JSON.parse(response.body)["data"]

    expect(found_item["attributes"]["id"]).to eq(item.id)
  end

  describe 'relationship endpoints' do
    it 'returns associated invoice_items' do
      merchant = create(:merchant)
      customer = create(:customer)
      item = create(:item, merchant: merchant)
      item_2 = create(:item, merchant: merchant)
      invoice_1 = create(:invoice, merchant: merchant, customer: customer)
      invoice_2 = create(:invoice, merchant: merchant, customer: customer)
      invoice_3 = create(:invoice, merchant: merchant, customer: customer)

      invoice_items_1 = create(:invoice_item, item: item, invoice: invoice_1)
      invoice_items_2 = create(:invoice_item, item: item, invoice: invoice_2)
      invoice_items_3 = create(:invoice_item, item: item, invoice: invoice_3)
      invoice_items_4 = create(:invoice_item, item: item_2, invoice: invoice_3)

      get "/api/v1/items/#{item.id}/invoice_items"

      expect(response).to be_successful

      invoice_items = JSON.parse(response.body)

      expect(invoice_items["data"].count).to eq(3)
      expect(invoice_items["data"][0]["id"]).to eq(invoice_items_1.id.to_s)
      expect(invoice_items["data"][1]["id"]).to eq(invoice_items_2.id.to_s)
      expect(invoice_items["data"][2]["id"]).to eq(invoice_items_3.id.to_s)
    end

    it 'returns associated merchant' do
      merchant = create(:merchant)
      item = create(:item, merchant: merchant)

      get "/api/v1/items/#{item.id}/merchant"

      found_merchant = JSON.parse(response.body)

      expect(found_merchant["data"]["id"]).to eq(merchant.id.to_s)
    end
  end
end

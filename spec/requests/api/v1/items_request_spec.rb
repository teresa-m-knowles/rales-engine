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
end

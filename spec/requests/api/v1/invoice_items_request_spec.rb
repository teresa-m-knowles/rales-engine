require 'rails_helper'

RSpec.describe 'Invoice Items Api' do
  describe 'shows all invoice items' do
    it 'invoice items index' do
      merchant = create(:merchant)
      item = create(:item, merchant: merchant)
      customer = create(:customer)
      invoice = create(:invoice, customer: customer, merchant: merchant)

      invoice_items = create_list(:invoice_item, 3, item: item, invoice: invoice)

      get "/api/v1/invoice_items"

      expect(response).to be_successful

      inv_items = JSON.parse(response.body)

      expect(inv_items["data"].count).to eq(3)
      expect(inv_items["data"].first["id"]).to eq(invoice_items.first.id.to_s)

    end
  end
  describe 'shows one invoice item' do
    it 'invoice items show' do
      merchant = create(:merchant)
      item = create(:item, merchant: merchant)
      customer = create(:customer)
      invoice = create(:invoice, customer: customer, merchant: merchant)

      invoice_item = create(:invoice_item, item: item, invoice: invoice)

      get "/api/v1/invoice_items/#{invoice_item.id}"

      expect(response).to be_successful

      in_it = JSON.parse(response.body)

      expect(in_it["data"]["id"]).to eq(invoice_item.id.to_s)
    end
  end

  describe 'finders' do
    it 'can find an invoice item by its attributes' do
      merchant = create(:merchant)
      item_1 = create(:item, merchant: merchant)
      item_2 = create(:item, merchant: merchant)
      customer = create(:customer)
      invoice = create(:invoice, customer: customer, merchant: merchant)
      invoice_item_1 = create(:invoice_item, item: item_1, invoice: invoice, quantity: 10)
      invoice_item_2 = create(:invoice_item, item: item_2, invoice: invoice)

      get "/api/v1/invoice_items/find?quantity=10"
      result = JSON.parse(response.body)

      expect(result["data"]["id"]).to eq(invoice_item_1.id.to_s)
    end

    it 'can find all invoice items that match the search parameters' do
      merchant = create(:merchant)
      merchant_2 = create(:merchant)
      item_1 = create(:item, merchant: merchant)
      item_2 = create(:item, merchant: merchant)
      customer = create(:customer)
      invoice = create(:invoice, customer: customer, merchant: merchant)
      invoice_2 = create(:invoice, customer: customer, merchant: merchant_2)
      invoice_item_1 = create(:invoice_item, item: item_1, invoice: invoice, unit_price: 1099)
      invoice_item_2 = create(:invoice_item, item: item_2, invoice: invoice)
      invoice_item_3 = create(:invoice_item, item: item_2, invoice: invoice_2, unit_price: 1099)

      get "/api/v1/invoice_items/find_all?unit_price=1099"

      result = JSON.parse(response.body)

      expect(result["data"].count).to eq(2)
      expect(result["data"][0]["id"]).to eq(invoice_item_1.id.to_s)
      expect(result["data"][1]["id"]).to eq(invoice_item_3.id.to_s)

    end
  end

  describe 'random' do
    it 'gets a random invoice item' do
      merchant = create(:merchant)
      item_1 = create(:item, merchant: merchant)
      item_2 = create(:item, merchant: merchant)
      customer = create(:customer)
      invoice = create(:invoice, customer: customer, merchant: merchant)
      invoice_item_1 = create(:invoice_item, item: item_1, invoice: invoice)
      invoice_item_1 = create(:invoice_item, item: item_2, invoice: invoice)

      get "/api/v1/invoice_items/random"

      result = JSON.parse(response.body)

      expect(result.count).to eq(1)
      expect(result["data"]["type"]).to eq("invoice_item")


    end
  end

  describe 'relationships' do
    before :each do
      @merchant = create(:merchant)
      @item = create(:item, merchant: @merchant)
      @customer = create(:customer)
      @invoice = create(:invoice, customer: @customer, merchant: @merchant)

      @invoice_item = create(:invoice_item, item: @item, invoice: @invoice)
    end
    it 'returns the associated invoice' do
      get "/api/v1/invoice_items/#{@invoice_item.id}/invoice"

      invoice = JSON.parse(response.body)

      expect(response).to be_successful

      expect(invoice["data"]["id"]).to eq(@invoice.id.to_s)

    end

    it 'returns the associated item' do
      get "/api/v1/invoice_items/#{@invoice_item.id}/item"

      item = JSON.parse(response.body)

      expect(response).to be_successful

      expect(item["data"]["id"]).to eq(@item.id.to_s)
    end
  end
end

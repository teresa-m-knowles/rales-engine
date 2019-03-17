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

      expect(invoice["data"])

    end

    it 'returns the associated item' do
    end
  end
end

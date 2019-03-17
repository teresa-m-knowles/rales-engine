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
end

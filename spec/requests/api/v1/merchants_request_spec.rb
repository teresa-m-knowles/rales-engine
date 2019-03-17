require 'rails_helper'

describe 'Merchants API' do
  it "sends a list of merchants" do
    create_list(:merchant, 3)

    get '/api/v1/merchants.json'
    merchants = JSON.parse(response.body)

    expect(response).to be_successful
    expect(merchants["data"].count).to eq(3)
  end

  it 'gets a merchant by its id' do
    id = create(:merchant).id

    get "/api/v1/merchants/#{id}.json"

    merchant = JSON.parse(response.body)
    expect(response).to be_successful
    expect(merchant["data"]["id"]).to eq(id.to_s)
  end

  it 'can find a merchant by its attributes' do
    merchant = create(:merchant, name: "Name")
    get "/api/v1/merchants/find?name=#{merchant.name}"

    found_merchant = JSON.parse(response.body)
    expect(response).to be_successful
    expect(merchant.name).to eq(found_merchant["data"]["attributes"]["name"])
  end

  it 'can find all merchants that match search parameters' do
    merchant_1 = create(:merchant, name: "Name", created_at: "2012-03-27T14:56:04.000Z")
    merchant_2 = create(:merchant, name: "Name")
    merchant_3 = create(:merchant, name: "Name")
    merchant_4 = create(:merchant, name: "Wrong Name", created_at: "2012-03-27T14:56:04.000Z")

    #Find by name
    get "/api/v1/merchants/find_all?name=Name"

    found_merchants = JSON.parse(response.body)
    expect(response).to be_successful
    expect(found_merchants["data"].count).to eq(3)

    expect(found_merchants["data"].first["id"]).to eq(merchant_1.id.to_s)
    expect(found_merchants["data"].second["id"]).to eq(merchant_2.id.to_s)
    expect(found_merchants["data"].third["id"]).to eq(merchant_3.id.to_s)


    #Find by created_at
    get "/api/v1/merchants/find_all?created_at=2012-03-27T14:56:04.000Z"
    found_merchants_by_date = JSON.parse(response.body)
    expect(response).to be_successful

    expect(found_merchants_by_date["data"].count).to eq(2)
    expect(found_merchants_by_date["data"].first["id"]).to eq(merchant_1.id.to_s)
    expect(found_merchants_by_date["data"].second["id"]).to eq(merchant_4.id.to_s)
  end

  it 'can get a random merchant' do
    create_list(:merchant, 5)

    get "/api/v1/merchants/random.json"

    merchant = JSON.parse(response.body)
    expect(response).to be_successful
    expect(merchant["data"].has_key?("id")).to eq(true)
  end

  it 'shows their items' do
    merchant = create(:merchant, name: "Nintendo")
    item_1 = create(:item, merchant: merchant)
    item_2 = create(:item, merchant: merchant)
    item_3 = create(:item, merchant: merchant)

    get "/api/v1/merchants/#{merchant.id}/items"
    expect(response).to be_successful

    items = JSON.parse(response.body)
    expect(items["data"].first["id"]).to eq(item_1.id.to_s)
    expect(items["data"].second["id"]).to eq(item_2.id.to_s)
    expect(items["data"].third["id"]).to eq(item_3.id.to_s)

  end

  it 'shows their invoices' do
    merchant = create(:merchant)
    customer = create(:customer)

    invoice_1 = create(:invoice, merchant: merchant, customer: customer)
    invoice_2 = create(:invoice, merchant: merchant, customer: customer)
    invoice_3 = create(:invoice, merchant: merchant, customer: customer)

    get "/api/v1/merchants/#{merchant.id}/invoices"
    expect(response).to be_successful

    invoices = JSON.parse(response.body)
    expect(invoices["data"].first["id"]).to eq(invoice_1.id.to_s)
    expect(invoices["data"].second["id"]).to eq(invoice_2.id.to_s)
    expect(invoices["data"].third["id"]).to eq(invoice_3.id.to_s)

  end

  

end

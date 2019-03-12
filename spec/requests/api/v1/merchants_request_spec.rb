require 'rails_helper'

describe 'Merchants API' do
  it "sends a list of merchants" do
    create_list(:merchant, 3)

    get '/api/v1/merchants.json'
    merchants = JSON.parse(response.body)

    expect(response).to be_successful
    expect(merchants.count).to eq(3)
  end

  it 'gets a merchant by its id' do
    id = create(:merchant).id

    get "/api/v1/merchants/#{id}.json"

    merchant = JSON.parse(response.body)
    expect(response).to be_successful
    expect(merchant["id"]).to eq(id)
  end

  it 'can search find a merchant by its attributes' do
    merchant = create(:merchant, name: "Name")
    get "/api/v1/merchants/find?name=#{merchant.name}"

    found_merchant = JSON.parse(response.body)
    expect(response).to be_successful

    expect(merchant.name).to eq(found_merchant["name"])
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

    expect(found_merchants.count).to eq(3)
    expect(found_merchants.first["id"]).to eq(merchant_1.id)
    expect(found_merchants.second["id"]).to eq(merchant_2.id)
    expect(found_merchants.third["id"]).to eq(merchant_3.id)


    #Find by created_at
    get "/api/v1/merchants/find_all?created_at=2012-03-27T14:56:04.000Z"
    found_merchants = JSON.parse(response.body)
    expect(response).to be_successful

    expect(found_merchants.count).to eq(2)
    expect(found_merchants.first["id"]).to eq(merchant_1.id)
    expect(found_merchants.second["id"]).to eq(merchant_4.id)
  end
end

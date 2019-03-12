require 'rails_helper'

describe 'Merchants API' do
  it "sends a list of merchants" do
    create_list(:merchant, 3)

    get '/api/v1/merchants'
    merchants = JSON.parse(response.body)

    expect(response).to be_successful
    expect(merchants.count).to eq(3)
  end

  it 'gets a merchant by its id' do
    id = create(:merchant).id

    get "/api/v1/merchants/#{id}"

    merchant = JSON.parse(response.body)
    expect(response).to be_successful
    expect(merchant["id"]).to eq(id)
  end

  it 'can search through the merchants by its attributes' do
    merchant = create(:merchant, name: "Name")
    get "/api/v1/merchants/find?name=#{merchant.name}"

    found_merchant = JSON.parse(response.body)
    expect(response).to be_successful

    expect(merchant.id).to eq(found_merchant["id"])
  end
end

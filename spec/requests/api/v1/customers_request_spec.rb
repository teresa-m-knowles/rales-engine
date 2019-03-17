require 'rails_helper'

RSpec.describe 'Customers API' do
  it 'returns all customers' do
    customers = create_list(:customer, 3)

    get "/api/v1/customers"

    expect(response).to be_successful

    result = JSON.parse(response.body)

    expect(result["data"].count).to eq(3)
  end
end

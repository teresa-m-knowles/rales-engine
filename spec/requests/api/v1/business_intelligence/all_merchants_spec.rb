require 'rails_helper'

describe 'All Merchants Business Intelligence' do
  it 'returns the top x merchants ranked by total revenue' do
    #GET /api/v1/merchants/most_revenue?quantity=x
    #returns the top x merchants ranked by total revenue
    merchant_1 = create(:merchant, name: "Merchant 1")
    merchant_2 = create(:merchant, name: "Merchant 2")
    merchant_3 = create(:merchant, name: "Merchant 3")
    merchant_4 = create(:merchant, name: "Merchant 4")
    merchant_5 = create(:merchant, name: "Merchant 5")

    customer = create(:customer)


    #The customer orders from 5 different merchants
#-----------------------------------------------------------------------------------------------------------
    #Invoice 1 is from merchant 1
    #Total revenue from invoice 1 is $100
    item_1 = create(:item, merchant: merchant_1, unit_price: 50 )
    item_2 = create(:item, merchant: merchant_1, unit_price: 25)

    invoice_1 = create(:invoice, customer: customer, merchant: merchant_1)
    create(:transaction, result:'success', invoice: invoice_1)
    invoice_item_1 = create(:invoice_item, invoice: invoice_1, item: item_1, quantity: 1, unit_price: 50)
    invoice_item_2 = create(:invoice_item, invoice: invoice_1, item: item_2, quantity: 2, unit_price: 25)
#--------------------------------------------------------------------------------------------------------

    #Invoice 2 from merchant 2
    #Total revenue from invoice 2 is $75
    item_3 = create(:item, merchant: merchant_2, unit_price: 25 )
    invoice_2 = create(:invoice, customer: customer, merchant: merchant_2)
    create(:transaction, result:'success', invoice: invoice_2)

    invoice_item_3 = create(:invoice_item, invoice: invoice_2, item: item_3, quantity: 3, unit_price: 25)
#--------------------------------------------------------------------------------------------------------

    #Invoice 3 from merchant 3
    #Total revenue from invoice 3 is $60
    item_4 = create(:item, merchant: merchant_3, unit_price: 20 )

    invoice_3 = create(:invoice, customer: customer, merchant: merchant_3)
    create(:transaction, result:'success', invoice: invoice_3)

    invoice_item_4 = create(:invoice_item, invoice: invoice_3, item: item_4, quantity: 3, unit_price: 20)

#--------------------------------------------------------------------------------------------------------
    #Invoice 4 from merchant 4
    #Revenue: $39
    item_5 = create(:item, merchant: merchant_4, unit_price: 3.50 )
    item_6 = create(:item, merchant: merchant_4, unit_price: 5)

    invoice_4 = create(:invoice, customer: customer, merchant: merchant_4)
    create(:transaction, result:'success', invoice: invoice_4)

    invoice_item_5 = create(:invoice_item, invoice: invoice_4, item: item_5, quantity: 4, unit_price: 3.50)
    invoice_item_6 = create(:invoice_item, invoice: invoice_4, item: item_6, quantity: 5, unit_price: 5)
#----------------------------------------------------------------------------------------------------------------

    #Invoice 5 from merchant 5
    item_7 = create(:item, merchant: merchant_5, unit_price: 2.77)

    invoice_5 = create(:invoice, customer: customer, merchant: merchant_5)
    create(:transaction, result:'success', invoice: invoice_5)

    invoice_item_7 = create(:invoice_item, invoice: invoice_5, item: item_7, quantity: 1, unit_price: 2.77 )
#----------------------------------------------------------------------------------------------

    get "/api/v1/merchants/most_revenue?quantity=3"

    expect(response).to be_successful

    merchants = JSON.parse(response.body)
    #This should return merchants 1, 2 and 3
    expect(merchants["data"].count).to eq(3)
    expect(merchants["data"][0]["id"]).to eq(merchant_1.id.to_s)
    expect(merchants["data"][1]["id"]).to eq(merchant_2.id.to_s)
    expect(merchants["data"][2]["id"]).to eq(merchant_3.id.to_s)


#---------------------------------------------------------------------------------------------------------------




  end

  it 'returns the top x merchants ranked by total number of items sold' do
  #GET /api/v1/merchants/most_items?quantity=x
  merchant_1 = create(:merchant, name: "Merchant 1")
  merchant_2 = create(:merchant, name: "Merchant 2")
  merchant_3 = create(:merchant, name: "Merchant 3")
  merchant_4 = create(:merchant, name: "Merchant 4")
  merchant_5 = create(:merchant, name: "Merchant 5")
  customer = create(:customer)

  #The customer orders from 5 different merchants
#-----------------------------------------------------------------------------------------------------------
  #Invoice 1 is from merchant 1
  #Total revenue from invoice 1 is $100
  #Sold 20 items
  item_1 = create(:item, merchant: merchant_1, unit_price: 50 )
  item_2 = create(:item, merchant: merchant_1, unit_price: 25)

  invoice_1 = create(:invoice, customer: customer, merchant: merchant_1)
  create(:transaction, result:'success', invoice: invoice_1)
  invoice_item_1 = create(:invoice_item, invoice: invoice_1, item: item_1, quantity: 10, unit_price: 50)
  invoice_item_2 = create(:invoice_item, invoice: invoice_1, item: item_2, quantity: 10, unit_price: 25)
#--------------------------------------------------------------------------------------------------------

  #Invoice 2 from merchant 2
  #Total revenue from invoice 2 is $75
  #Sold 15 items
  item_3 = create(:item, merchant: merchant_2, unit_price: 25 )
  invoice_2 = create(:invoice, customer: customer, merchant: merchant_2)
  create(:transaction, result:'success', invoice: invoice_2)

  invoice_item_3 = create(:invoice_item, invoice: invoice_2, item: item_3, quantity: 15, unit_price: 25)
#--------------------------------------------------------------------------------------------------------

  #Invoice 3 from merchant 3
  #Total revenue from invoice 3 is $60
  #Sold 13 items
  item_4 = create(:item, merchant: merchant_3, unit_price: 20 )

  invoice_3 = create(:invoice, customer: customer, merchant: merchant_3)
  create(:transaction, result:'success', invoice: invoice_3)

  invoice_item_4 = create(:invoice_item, invoice: invoice_3, item: item_4, quantity: 13, unit_price: 20)

#--------------------------------------------------------------------------------------------------------
  #Invoice 4 from merchant 4
  #Revenue: $39
  #Sold 5 items
  item_5 = create(:item, merchant: merchant_4, unit_price: 3.50 )
  item_6 = create(:item, merchant: merchant_4, unit_price: 5)

  invoice_4 = create(:invoice, customer: customer, merchant: merchant_4)
  create(:transaction, result:'success', invoice: invoice_4)

  invoice_item_5 = create(:invoice_item, invoice: invoice_4, item: item_5, quantity: 3, unit_price: 3.50)
  invoice_item_6 = create(:invoice_item, invoice: invoice_4, item: item_6, quantity: 2, unit_price: 5)
#----------------------------------------------------------------------------------------------------------------

  #Invoice 5 from merchant 5
  #Sold 1 item
  item_7 = create(:item, merchant: merchant_5, unit_price: 2.77)

  invoice_5 = create(:invoice, customer: customer, merchant: merchant_5)
  create(:transaction, result:'success', invoice: invoice_5)

  invoice_item_7 = create(:invoice_item, invoice: invoice_5, item: item_7, quantity: 1, unit_price: 2.77 )
  #----------------------------------------------------------------------------------------------------------------

  get "/api/v1/merchants/most_items?quantity=3"

  expect(response).to be_successful
  merchants = JSON.parse(response.body)

  expect(merchants["data"].count).to eq(3)
  expect(merchants["data"][0]["id"]).to eq(merchant_1.id.to_s)
  expect(merchants["data"][1]["id"]).to eq(merchant_2.id.to_s)
  expect(merchants["data"][2]["id"]).to eq(merchant_3.id.to_s)

  end

  xit 'returns the returns the total revenue for date x across all merchants' do
    #GET /api/v1/merchants/revenue?date=x
    merchant_1 = create(:merchant)
    merchant_2 = create(:merchant)

    customer = create(:customer)

    #From merchant 1
    item_1 = create(:item, merchant: merchant_1, unit_price: 15.23)
    invoice_1 = create(:invoice, merchant: merchant_1, created_at: '2012-03-25 09:54:09 UTC' )
    invoice_item_1 = create(:invoice_item, item: item_1, invoice: invoice_1, quantity: 1)



   #  merchant1 = create(:merchant)
   # item1 = create(:item, merchant_id: merchant1.id)
   # invoice1 = create(:invoice, merchant_id: merchant1.id, created_at: "2012-03-25 09:54:09 UTC" )
   # invoice_item1 = create(:invoice_item, item_id: item1.id, invoice_id: invoice1.id, quantity: 10, unit_price: 10)
   # invoice_item3 = create(:invoice_item, item_id: item1.id, invoice_id: invoice1.id, quantity: 5, unit_price: 5)
   # transaction1 = create(:transaction, invoice_id: invoice1.id)
   # invoice2 = create(:invoice, merchant_id: merchant1.id, created_at: "2011-04-21 02:00:00 UTC" )
   # invoice_item2 = create(:invoice_item, item_id: item1.id, invoice_id: invoice2.id, quantity: 10, unit_price: 10, created_at: "2011-04-21 02:00:00 UTC")
   # transaction2 = create(:transaction, invoice_id: invoice2.id, created_at: "2011-04-21 02:00:00 UTC")
   # id = merchant1.id
   # date = "2012-03-25 09:54:09 UTC"
   #
   # get "/api/v1/merchants/#{id}/revenue?date=#{date}"
   #
   # number = JSON.parse(response.body)["data"]["attributes"]["date_revenue"]
   #
   # expect(response).to be_successful


  end
end

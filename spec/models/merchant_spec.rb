require 'rails_helper'

RSpec.describe Merchant, type: :model do
  describe 'validations' do
    it {should validate_presence_of :name}
    it {should validate_length_of(:name)
      .is_at_least(1)}
  end

  describe 'relationships' do
    it {should have_many :items}
    it {should have_many :invoices}
  end

  describe 'Class methods' do
    describe 'returns the top merchants by revenue' do
      it '.most_revenue' do
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
        create(:transaction, invoice: invoice_1, result: 'success')
        invoice_item_1 = create(:invoice_item, invoice: invoice_1, item: item_1, quantity: 1, unit_price: 50)
        invoice_item_2 = create(:invoice_item, invoice: invoice_1, item: item_2, quantity: 2, unit_price: 25)
    #--------------------------------------------------------------------------------------------------------

        #Invoice 2 from merchant 2
        #Total revenue from invoice 2 is $75
        item_3 = create(:item, merchant: merchant_2, unit_price: 25 )
        invoice_2 = create(:invoice, customer: customer, merchant: merchant_2)
        create(:transaction, invoice: invoice_2, result: 'success')
        invoice_item_3 = create(:invoice_item, invoice: invoice_2, item: item_3, quantity: 3, unit_price: 25)
    #--------------------------------------------------------------------------------------------------------

        #Invoice 3 from merchant 3
        #Total revenue from invoice 3 is $60
        item_4 = create(:item, merchant: merchant_3, unit_price: 20 )

        invoice_3 = create(:invoice, customer: customer, merchant: merchant_3)
        create(:transaction, invoice: invoice_3, result: 'success')
        invoice_item_4 = create(:invoice_item, invoice: invoice_3, item: item_4, quantity: 3, unit_price: 20)

    #--------------------------------------------------------------------------------------------------------
        #Invoice 4 from merchant 4
        #Revenue: $39
        item_5 = create(:item, merchant: merchant_4, unit_price: 3.50 )
        item_6 = create(:item, merchant: merchant_4, unit_price: 5)

        invoice_4 = create(:invoice, customer: customer, merchant: merchant_4)
        create(:transaction, invoice: invoice_4, result: 'success')
        invoice_item_5 = create(:invoice_item, invoice: invoice_4, item: item_5, quantity: 4, unit_price: 3.50)
        invoice_item_6 = create(:invoice_item, invoice: invoice_4, item: item_6, quantity: 5, unit_price: 5)
    #----------------------------------------------------------------------------------------------------------------

        #Invoice 5 from merchant 5
        item_7 = create(:item, merchant: merchant_5, unit_price: 2.77)

        invoice_5 = create(:invoice, customer: customer, merchant: merchant_5)
        create(:transaction, invoice: invoice_5, result: 'success')
        invoice_item_7 = create(:invoice_item, invoice: invoice_5, item: item_7, quantity: 1, unit_price: 2.77 )
        #----------------------------------------------------------------------------------------------------------------
        expect(Merchant.most_revenue(3).first).to eq(merchant_1)
        expect(Merchant.most_revenue(3).second).to eq(merchant_2)
        expect(Merchant.most_revenue(3).third).to eq(merchant_3)

        expect(Merchant.most_revenue(3).first.revenue).to eq(100)
        expect(Merchant.most_revenue(3).second.revenue).to eq(75)
        expect(Merchant.most_revenue(3).third.revenue).to eq(60)
      end
    end

    describe 'returns the top merchants by quantity of items sold' do
      it '.most_items' do
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
        create(:transaction, invoice: invoice_1, result: 'success')
        invoice_item_1 = create(:invoice_item, invoice: invoice_1, item: item_1, quantity: 10, unit_price: 50)
        invoice_item_2 = create(:invoice_item, invoice: invoice_1, item: item_2, quantity: 10, unit_price: 25)
      #--------------------------------------------------------------------------------------------------------

        #Invoice 2 from merchant 2
        #Total revenue from invoice 2 is $75
        #Sold 15 items
        item_3 = create(:item, merchant: merchant_2, unit_price: 25 )
        invoice_2 = create(:invoice, customer: customer, merchant: merchant_2)
        create(:transaction, invoice: invoice_2, result: 'success')
        invoice_item_3 = create(:invoice_item, invoice: invoice_2, item: item_3, quantity: 15, unit_price: 25)
      #--------------------------------------------------------------------------------------------------------

        #Invoice 3 from merchant 3
        #Total revenue from invoice 3 is $60
        #Sold 13 items
        item_4 = create(:item, merchant: merchant_3, unit_price: 20 )

        invoice_3 = create(:invoice, customer: customer, merchant: merchant_3)
        create(:transaction, invoice: invoice_3, result: 'success')
        invoice_item_4 = create(:invoice_item, invoice: invoice_3, item: item_4, quantity: 13, unit_price: 20)

      #--------------------------------------------------------------------------------------------------------
        #Invoice 4 from merchant 4
        #Revenue: $39
        #Sold 5 items
        item_5 = create(:item, merchant: merchant_4, unit_price: 3.50 )
        item_6 = create(:item, merchant: merchant_4, unit_price: 5)

        invoice_4 = create(:invoice, customer: customer, merchant: merchant_4)
        create(:transaction, invoice: invoice_4, result: 'success')
        invoice_item_5 = create(:invoice_item, invoice: invoice_4, item: item_5, quantity: 3, unit_price: 3.50)
        invoice_item_6 = create(:invoice_item, invoice: invoice_4, item: item_6, quantity: 2, unit_price: 5)
      #----------------------------------------------------------------------------------------------------------------

        #Invoice 5 from merchant 5
        #Sold 1 item
        item_7 = create(:item, merchant: merchant_5, unit_price: 2.77)

        invoice_5 = create(:invoice, customer: customer, merchant: merchant_5)
        create(:transaction, invoice: invoice_5, result: 'success')
        invoice_item_7 = create(:invoice_item, invoice: invoice_5, item: item_7, quantity: 1, unit_price: 2.77 )
        #----------------------------------------------------------------------------------------------------------------
        merchants = Merchant.most_items(3)
        expect(merchants.first).to eq(merchant_1)
        expect(merchants.second).to eq(merchant_2)
        expect(merchants.third).to eq(merchant_3)

      end
    end

    describe 'it returns the total revenue for a given date across all merchants' do
      xit 'total_revenue' do
        date_wanted = '2012-03-25 09:54:09 UTC'
        unwanted_date = '2012-03-30 09:54:09 UTC'
        merchant_1 = create(:merchant)
        merchant_2 = create(:merchant)

        customer = create(:customer)

        #From merchant 1
        #Revenue is 15.23
        item_1 = create(:item, merchant: merchant_1, unit_price: 15.23)
        invoice_1 = create(:invoice, customer: customer, merchant: merchant_1, created_at: date_wanted)
        invoice_item_1 = create(:invoice_item, item: item_1, invoice: invoice_1, quantity: 1)
        transaction_1 = create(:transaction, invoice: invoice_1, result: 'success')

        #------------------------------------------------------
        #From merchant 2, revenue is $10
        item_2 = create(:item, merchant: merchant_2, unit_price: 10)
        invoice_2 = create(:invoice, customer: customer, merchant: merchant_2, created_at: date_wanted)
        invoice_item_2 = create(:invoice_item, item: item_2, invoice: invoice_2, quantity: 1)
        transaction_2 = create(:transaction, invoice: invoice_2, result: 'success')
        #Total for wanted date should be $25.23
        #-------------------------------------------------
        #From merchant 1, unwanted date:revenue is $20
        invoice_3 = create(:invoice, customer: customer, merchant: merchant_1, created_at: unwanted_date)
        invoice_item_3 = create(:invoice_item, item: item_1, invoice: invoice_3, quantity: 1)
        transaction_3 = create(:transaction, invoice: invoice_3, result: 'success')
        #-----------------------------------------

        expect(Merchant.total_revenue(date_wanted)).to eq(25.23)
      end
    end



  end

  describe 'Instance methods' do
    describe 'it returns the total revenue for a merchant for successful transactions' do
      it 'total_revenue' do
        merchant_1 = create(:merchant)
        merchant_2 = create(:merchant)
        customer = create(:customer)
        #GET /api/v1/merchants/:id/revenue

        #Invoice from merchant 1
        #Revenue is $100 from 1 successful transaction
        invoice_1 = create(:invoice, merchant: merchant_1, customer: customer)
        item_1 = create(:item, unit_price: 10, merchant: merchant_1)
        invoice_item_1 = create(:invoice_item, item: item_1, invoice: invoice_1, quantity: 10)
        transaction_1 = create(:transaction, invoice: invoice_1, result: 'success')

        invoice_2 = create(:invoice, merchant: merchant_1, customer: customer)
        invoice_item_2 = create(:invoice_item, item: item_1, invoice: invoice_2, quantity: 5)
        transaction_2 = create(:transaction, invoice: invoice_1, result: 'failed')
    #-------------------------------------------------------------------------------
        #From merchant 2 revenue is $46
        invoice_3 = create(:invoice, merchant: merchant_2, customer: customer)
        item_2 = create(:item, unit_price: 23, merchant: merchant_2)
        invoice_item_3 = create(:invoice_item, item: item_2, invoice: invoice_3, quantity: 2)
        transaction_3 = create(:transaction, invoice: invoice_3, result: 'success')

        invoice_4 = create(:invoice, merchant: merchant_2, customer: customer)
        invoice_item_3 = create(:invoice_item, item: item_2, invoice: invoice_4, quantity: 1)
        transaction_3 = create(:transaction, invoice: invoice_3, result: 'failed')
        #------------------------------------------------
        expect(merchant_1.revenue).to eq(100)
        expect(merchant_2.revenue).to eq(46)
      end
    end

    describe 'it returns the favorite customer, which is returns the customer who has conducted the most total number of successful transactions ' do
      it 'favorite_customer' do
        merchant = create(:merchant)
        customer_1 = create(:customer)
        customer_2 = create(:customer)
        #Customer 1 has 3 transactions, customer 2 has 1

        item_1 = create(:item, unit_price: 10, merchant: merchant)
        invoice_1 = create(:invoice, merchant: merchant, customer: customer_1)
        invoice_item_1 = create(:invoice_item, item: item_1, invoice: invoice_1)
        transaction_1 = create(:transaction, invoice: invoice_1, result: 'success')

        invoice_2 = create(:invoice, merchant: merchant, customer: customer_1)
        invoice_item_2 = create(:invoice_item, item: item_1, invoice: invoice_2, quantity: 5)
        transaction_2 = create(:transaction, invoice: invoice_1, result: 'success')

        invoice_3 = create(:invoice, merchant: merchant, customer: customer_1)
        item_2 = create(:item, unit_price: 23, merchant: merchant)
        invoice_item_3 = create(:invoice_item, item: item_1, invoice: invoice_3)
        transaction_3 = create(:transaction, invoice: invoice_1, result: 'success')

        invoice_4 = create(:invoice, merchant: merchant, customer: customer_2)
        invoice_item_3 = create(:invoice_item, item: item_2, invoice: invoice_4, quantity: 1)
        transaction_3 = create(:transaction, invoice: invoice_3, result: 'success')

        expect(merchant.favorite_customer).to eq(customer_1)
      end
    end
  end
end

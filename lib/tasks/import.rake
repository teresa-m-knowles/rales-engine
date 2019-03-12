require 'csv'

namespace :import do
  desc "Import from csv file"
  task merchants: :environment do
    CSV.foreach("lib/seeds/merchants.csv", headers: true) do |row|
      Merchant.create!(row.to_hash)
    end
    puts "Created #{Merchant.count} merchants."
  end

  task items: :environment do
    CSV.foreach("lib/seeds/items.csv", headers: true) do |row|
      Item.create!(row.to_hash)
      puts "Created #{Item.count} items."
    end
  end

  task customers: :environment do
    CSV.foreach("lib/seeds/customers.csv", headers: true) do |row|
      Customer.create!(row.to_hash)
      puts "Created #{Customer.count} customers."
    end
  end

  task invoices: :environment do
    CSV.foreach("lib/seeds/invoices.csv", headers: true) do |row|
      Invoice.create!(row.to_hash)
      puts "Created #{Invoice.count} invoices."
    end
  end

  task invoiceitems: :environment do
    CSV.foreach("lib/seeds/invoice_items.csv", headers: true) do |row|
      InvoiceItem.create!(row.to_hash)
      puts "Created #{InvoiceItem.count} invoiceitems."
    end
  end

  task transactions: :environment do
    CSV.foreach("lib/seeds/transactions.csv", headers: true) do |row|
      Transaction.create!(row.to_hash)
      puts "Created #{Transaction.count} transactions."
    end
  end

end

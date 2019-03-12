require 'csv'

namespace :import do
  desc "Import from csv file"
  task merchants: :environment do
    CSV.foreach("lib/seeds/merchants.csv", headers: true) do |row|
      Merchant.create!(row.to_hash)
    end
  end

  task items: :environment do
    CSV.foreach("lib/seeds/items.csv", headers: true) do |row|
      Item.create!(row.to_hash)
    end
  end

end

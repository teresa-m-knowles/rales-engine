require 'csv'

namespace :import do
  desc "Import from csv file"
  task merchants: :environment do
    CSV.foreach("lib/seeds/merchants.csv", headers: true) do |row|
      Merchant.create!(row.to_hash)
    end
  end

end

require_relative '../../lib/price_formatter.rb'
class RevenueSerializer
  include FastJsonapi::ObjectSerializer
  include PriceFormatter

  attribute :revenue do |object|
    '%.2f' % (object.revenue.to_f / 100).to_s
  end
end

class RevenueByDateSerializer
  include FastJsonapi::ObjectSerializer

  attribute :revenue do |object|
    '%.2f' % (object.revenue_by_date.to_f / 100).to_s
  end

end

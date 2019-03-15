class TotalRevenue
  attr_reader :total_revenue, :id

  def initialize(revenue_number)
    @total_revenue =   '%.2f' % (revenue_number.to_f / 100).to_s
    @id = 1

  end


end

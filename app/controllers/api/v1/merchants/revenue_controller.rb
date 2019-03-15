
class Api::V1::Merchants::RevenueController < ApplicationController
  def show
    if params["id"] && !params["date"]
      merchant = Merchant.find(params["id"])

      render json: RevenueSerializer.new(merchant)
    elsif params["id"] && params["date"]
      merchant = Merchant.find(params["id"])

      revenue = merchant.revenue_by_date(params["date"])
      render json: RevenueSerializer.new(revenue)
    elsif params["date"] && !params["id"]
      amount = Merchant.total_revenue(params["date"])
      render json: TotalSerializer.new(TotalRevenue.new(amount))

    end

  end
end

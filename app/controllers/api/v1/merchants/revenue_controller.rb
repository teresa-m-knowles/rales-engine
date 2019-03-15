class Api::V1::Merchants::RevenueController < ApplicationController
  def show
    merchant = Merchant.find(params["id"])

    if params["id"] && !params["date"]
      render json: RevenueSerializer.new(merchant)
    elsif params["id"] && params["date"]
      revenue = merchant.revenue_by_date(params["date"])
      render json: RevenueSerializer.new(revenue)
    end
  end
end

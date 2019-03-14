class Api::V1::Merchants::RevenueController < ApplicationController
  def show
    merchant = Merchant.find(params["id"])
    render json: {"revenue"=> format_revenue(merchant.revenue)}
  end
end

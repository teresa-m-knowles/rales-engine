class Api::V1::Merchants::RevenueByDateController < ApplicationController
  def show
    merchant = Merchant.find(params["id"])
    render json: {"data"=> {"attributes" => {'total_revenue': merchant.revenue(params["date"])}}}

  end
end

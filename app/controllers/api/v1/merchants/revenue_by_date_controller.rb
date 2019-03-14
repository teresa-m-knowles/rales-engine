class Api::V1::Merchants::RevenueByDateController < ApplicationController
  def show
    render json: {"data"=> {"attributes" => {'total_revenue': Merchant.total_revenue(params["date"])}}}

  end
end

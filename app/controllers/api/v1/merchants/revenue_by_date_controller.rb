class Api::V1::Merchants::RevenueByDateController < ApplicationController
  def show
    render json: {total_revenue: Merchant.total_revenue(params["date"])}

  end
end

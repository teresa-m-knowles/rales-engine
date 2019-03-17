class Api::V1::Invoices::SearchController < ApplicationController
  def show
    render json: InvoiceSerializer.new(Invoice.find_by(search_params(params)))
  end

  def index
    render json: InvoiceSerializer.new(Invoice.where(search_params(params)))
  end

  private

  def search_params(params)
    params.permit(:id, :created_at, :updated_at, :merchant_id, :customer_id, :status)

  end
end

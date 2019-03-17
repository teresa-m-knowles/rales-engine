class Api::V1::InvoiceItems::SearchController < ApplicationController
  def show
    render json: InvoiceItemSerializer.new(InvoiceItem.find_by(search_params(params)))
  end

  def index
    render json: InvoiceItemSerializer.new(InvoiceItem.where(search_params(params)))
  end

  private

  def search_params(params)
    if params[:unit_price]
      params[:unit_price] = params[:unit_price].gsub('.', '').to_i
    end
    params.permit(:id, :unit_price, :item_id, :invoice_id, :quantity, :created_at, :updated_at)

  end
end

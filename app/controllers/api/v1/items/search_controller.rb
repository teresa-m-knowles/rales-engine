class Api::V1::Items::SearchController < ApplicationController

  def show
    render json: ItemSerializer.new(Item.find_by(search_params(params)))
  end

  def index
    render json: ItemSerializer.new(Item.where(search_params(params)))
  end

  private

  def search_params(params)
    if params[:unit_price]
      params[:unit_price] = params[:unit_price].gsub('.', '').to_i
    end
    params.permit(:id, :name, :description, :unit_price, :merchant_id, :created_at, :updated_at )

  end
end

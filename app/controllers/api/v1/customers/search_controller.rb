class Api::V1::Customers::SearchController < ApplicationController
  def show
    render json: CustomerSerializer.new(Customer.find_by(search_params(params)))
  end

  def index
    render json: CustomerSerializer.new(Customer.where(search_params(params)))
  end

  private

  def search_params(params)
    params.permit(:id, :first_name, :last_name, :created_at, :updated_at)

  end
end

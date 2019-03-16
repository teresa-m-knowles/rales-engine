class Api::V1::Items::MostItemsController < ApplicationController
  def index
    render json: ItemSerializer.new(Item.top_selling(params["quantity"]))

  end
end

class Api::V1::Invoices::TransactionsController < ApplicationController
  def index
    invoice = Invoice.find(params["invoice_id"].to_i)

    render json: TransactionSerializer.new(invoice.transactions.all)

  end
end

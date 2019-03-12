class InvoiceSerializer
  include FastJsonapi::ObjectSerializer
  attributes :customer_id, :merchant_id, :status, :created_at, :updated_at
end

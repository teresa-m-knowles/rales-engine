class InvoiceItem < ApplicationRecord
  belongs_to :item
  belongs_to :invoice

  validates_presence_of :quantity, :unit_price, :created_at, :updated_at
end

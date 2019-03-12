class Item < ApplicationRecord
  belongs_to :merchant
  has_many :invoiceitems
  has_many :invoices, through: :invoiceitems
end

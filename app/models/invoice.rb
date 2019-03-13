class Invoice < ApplicationRecord
  belongs_to :customer
  belongs_to :merchant
  has_many :transactions
  has_many :invoice_items

  validates_presence_of :status
  validates_presence_of :created_at
  validates_presence_of :updated_at

  enum status: ['shipped']

end

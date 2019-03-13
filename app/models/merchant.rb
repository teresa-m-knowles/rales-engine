class Merchant < ApplicationRecord
  validates :name, presence: true, length: { minimum: 1 }
  has_many :items
  has_many :invoices


  def self.most_revenue(quantity)
    joins(invoices: :invoice_items)
    .select('merchants.*, sum(invoice_items.quantity * invoice_items.unit_price) as revenue')
    .group(:id)
    .order('revenue desc')
    .limit(quantity)
  end

  def self.most_items(quantity)
    joins(invoices: :invoice_items)
    .select('merchants.*, sum(invoice_items.quantity) as items_sold')
    .group(:id)
    .order('items_sold desc')
    .limit(quantity)
  end
end

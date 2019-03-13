class Merchant < ApplicationRecord
  validates :name, presence: true, length: { minimum: 1 }
  has_many :items
  has_many :invoices


  def self.most_revenue(quantity)
    Merchant.joins(invoices: :invoice_items)
            .select('merchants.*, sum(invoice_items.quantity * invoice_items.unit_price) as revenue')
            .group(:id)
            .order('revenue desc')
            .limit(quantity)
  end
end

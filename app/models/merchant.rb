class Merchant < ApplicationRecord
  validates :name, presence: true, length: { minimum: 1 }
  has_many :items
  has_many :invoices


  def self.most_revenue(quantity)
    joins(invoices: [:invoice_items, :transactions])
    .select('merchants.*, sum(invoice_items.quantity * invoice_items.unit_price) as revenue')
    .merge(Transaction.unscoped.successful)
    .group(:id)
    .order('revenue desc')
    .limit(quantity)
  end

  def self.most_items(quantity)
    select('merchants.*, sum(invoice_items.quantity) as items_sold')
    .joins(invoices: [:invoice_items, :transactions])
    .merge(Transaction.unscoped.successful)
    .group(:id)
    .order('items_sold desc')
    .limit(quantity)
  end

  def revenue
    invoices.joins(:invoice_items, :transactions)
            .merge(Transaction.unscoped.successful)
            .sum('invoice_items.quantity * invoice_items.unit_price')
  end

  def revenue_by_date(date)
    invoices.joins(:invoice_items, :transactions)
            .where(created_at: Date.parse(date).all_day)
            .merge(Transaction.unscoped.successful)
            .group(:id)
            .select('sum(invoice_items.quantity * invoice_items.unit_price) as revenue')
            .first
  end

end

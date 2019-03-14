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

  def self.total_revenue(date)
    date = DateTime.parse(date)
    Merchant.joins(invoices: [:invoice_items, :transactions])
            .where("invoices.created_at LIKE ?", "%#{date.to_time}%" )
            .merge(Transaction.unscoped.successful)
            .sum('invoice_items.quantity * invoice_items.unit_price')
  end

  def revenue
    invoices.joins(:invoice_items, :transactions)
            .merge(Transaction.unscoped.successful)
            .sum('invoice_items.quantity * invoice_items.unit_price')
  end

end

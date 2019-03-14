class Item < ApplicationRecord
  validates_presence_of :name
  validates_presence_of :description
  validates_presence_of :unit_price
  validates_presence_of :created_at
  validates_presence_of :updated_at

  belongs_to :merchant
  has_many :invoice_items
  has_many :invoices, through: :invoice_items

  def self.top_revenue(item_count)
    Item.joins(invoice_items: [invoice: :transactions])
        .merge(Transaction.unscoped.successful)
        .select('items.*, sum(invoice_items.quantity * invoice_items.unit_price) as revenue')
        .group(:id)
        .order('revenue desc')
        .limit(item_count)
  end
end

class Customer < ApplicationRecord
  has_many :invoices
  validates_presence_of :first_name
  validates_presence_of :last_name
  validates_presence_of :created_at
  validates_presence_of :updated_at

  def self.favorite_customer(merchant_id)
    Customer.joins(invoices: :transactions)
            .where('invoices.merchant_id = ?', merchant_id)
            .merge(Transaction.unscoped.successful)
            .group(:id)
            .order('count(transactions.id) desc')
            .first
  end
end

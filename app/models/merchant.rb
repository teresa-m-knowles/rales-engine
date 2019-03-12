class Merchant < ApplicationRecord
  validates :name, presence: true, length: { minimum: 1 }
  has_many :items
  has_many :invoices
end

class Transaction < ApplicationRecord
  belongs_to :invoice

  validates_presence_of :credit_card_number, :credit_card_expiration_date, :result, :created_at, :updated_at

  enum result: ['success', 'failed']

  scope :successful, -> { where(result: 'success')}

  default_scope { order(:id)}
end

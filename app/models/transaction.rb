class Transaction < ApplicationRecord
  belongs_to :invoice

  validates_presence_of :credit_card_number, :result, :created_at, :updated_at

  enum result: ['success', 'failed']

  scope :successful, -> { where(result: 'success')}

  default_scope { order(:id)}
end

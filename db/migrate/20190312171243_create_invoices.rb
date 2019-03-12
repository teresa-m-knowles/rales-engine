class CreateInvoices < ActiveRecord::Migration[5.2]
  def change
    create_table :invoices do |t|
      t.integer :status
      t.datetime :created_at
      t.datetime :updated_at
      t.references :customer, foreign_key: true
      t.references :merchant, foreign_key: true

    end
  end
end

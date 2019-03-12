class CreateTransactions < ActiveRecord::Migration[5.2]
  def change
    create_table :transactions do |t|
      t.string :credit_card_number
      t.integer :result
      t.datetime :created_at
      t.datetime :updated_at
      t.references :invoice, foreign_key: true

    end
  end
end

class ChangeMerchants < ActiveRecord::Migration[5.2]
  def change
    remove_column :merchants, :created_at
    remove_column :merchants, :updated_at
    add_column :merchants, :created_at, :string
    add_column :merchants, :updated_at, :string
  end
end

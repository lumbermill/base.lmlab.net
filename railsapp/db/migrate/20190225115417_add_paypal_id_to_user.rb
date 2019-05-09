class AddPaypalIdToUser < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :paypal_id, :string, default: '', null: false
  end
end

class CreateOrders < ActiveRecord::Migration[5.1]
  def change
    create_table :orders do |t|
      t.integer :user_id
      t.integer :slip_id
      t.integer :product_id
      t.integer :amount
      t.string :status

      t.timestamps
    end
  end
end

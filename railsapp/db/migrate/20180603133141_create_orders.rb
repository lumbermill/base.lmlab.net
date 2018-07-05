class CreateOrders < ActiveRecord::Migration[5.1]
  def change
    create_table :orders do |t|
      t.integer :user_id, null: false, default: 0
      t.integer :slip_id
      t.integer :product_id, null: false, default: 0
      t.integer :amount, null: false, default: 1
      t.string :status, null: false, default: "in-cart"

      t.timestamps
    end
  end
end

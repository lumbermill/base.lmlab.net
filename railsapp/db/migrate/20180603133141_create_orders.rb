class CreateOrders < ActiveRecord::Migration[5.1]
  def change
    create_table :orders do |t|
      t.integer :user_id, null: false, default: 0
      t.datetime :checkout_at
      t.integer :product_id, null: false, default: 0
      t.integer :quantity, null: false, default: 1
      t.integer :price, null: false, default: 1
      t.string :status, null: false, default: "in-cart"

      t.timestamps
    end
  end
end

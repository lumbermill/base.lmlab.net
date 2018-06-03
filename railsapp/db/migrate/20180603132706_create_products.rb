class CreateProducts < ActiveRecord::Migration[5.1]
  def change
    create_table :products do |t|
      t.integer :user_id
      t.bigint :code
      t.string :maker
      t.string :name
      t.string :size
      t.integer :price
      t.decimal :cost
      t.integer :picture_id
      t.string :copy
      t.string :memo

      t.timestamps
    end
  end
end

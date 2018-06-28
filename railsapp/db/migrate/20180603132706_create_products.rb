class CreateProducts < ActiveRecord::Migration[5.1]
  def change
    create_table :products do |t|
      t.integer :user_id
      t.bigint :code, null: false, default: 0
      t.string :maker, null: false, default: ""
      t.string :name, null: false, default: ""
      t.string :size, null: false, default: ""
      t.integer :price, null: false, default: 0
      t.decimal :cost, null: false, default: 0
      t.integer :picture_id
      t.string :copy, null: false, default: ""
      t.string :memo, null: false, default: ""

      t.timestamps
    end
  end
end

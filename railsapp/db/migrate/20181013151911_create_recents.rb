class CreateRecents < ActiveRecord::Migration[5.1]
  def change
    create_table :recents do |t|
      t.integer :product_id
      t.datetime :viewed_time

      t.timestamps
    end
  end
end

class CreateRecents < ActiveRecord::Migration[5.1]
  def change
    create_table :recents do |t|
      t.integer :product_code
      t.datetime :viewed

      t.timestamps
    end
  end
end

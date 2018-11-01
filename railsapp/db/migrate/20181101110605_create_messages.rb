class CreateMessages < ActiveRecord::Migration[5.1]
  def change
    create_table :messages do |t|
      t.integer :sender_id
      t.integer :receiver_id
      t.string :type
      t.string :body
      t.boolean :opened

      t.timestamps
    end
  end
end

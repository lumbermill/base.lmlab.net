class AddColumnsToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :birthdate, :date
    add_column :users, :phone_no, :string
    add_column :users, :memo, :string
  end
end

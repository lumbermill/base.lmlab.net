class AddUserIdToRecents < ActiveRecord::Migration[5.1]
  def change
    add_column :recents, :user_id, :integer
  end
end

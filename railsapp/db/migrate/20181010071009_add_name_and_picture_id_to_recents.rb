class AddNameAndPictureIdToRecents < ActiveRecord::Migration[5.1]
  def change
    add_column :recents, :name, :string
    add_column :recents, :picture_id, :integer
  end
end

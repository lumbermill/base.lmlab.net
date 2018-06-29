class CreateTags < ActiveRecord::Migration[5.1]
  def change
    create_table :tags do |t|
      t.string :code, null: false, default: ""
      t.string :name, null: false, default: ""
      t.string :copy, null: false, default: ""
      t.string :memo, null: false, default: ""

      t.timestamps
    end
  end
end

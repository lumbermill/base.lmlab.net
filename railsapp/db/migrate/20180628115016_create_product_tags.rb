class CreateProductTags < ActiveRecord::Migration[5.1]
  def change
    create_table :product_tags do |t|
      t.references :product, foreign_key: true
      t.references :tag, foreign_key: true

      t.timestamps
    end
  end
end

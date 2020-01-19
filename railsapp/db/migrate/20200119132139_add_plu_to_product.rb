class AddPluToProduct < ActiveRecord::Migration[5.1]
  def change
    # amwayの発注コードとバーコードが異なるため止む無く追加 20.01.19
    add_column :products, :code4plu, :string, null: false, default: ""
  end
end

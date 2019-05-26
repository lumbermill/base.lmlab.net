class ChangeCodeOnProducts < ActiveRecord::Migration[5.1]
  def change
    change_column :products, :code, :string
  end
end

# The migration only worked on development. I don't know why..
# So I ran the following SQLs to change the column type of `code`.
# alter table products change column code code_old bigint;
# alter table products add column code varchar(255) not null default '0' after code_old;
# update products set code = code_old;
# alter table products drop column code_old;

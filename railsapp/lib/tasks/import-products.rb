
require 'csv'

# Import products from tsv file which is exported from the sheet.
# https://docs.google.com/spreadsheets/d/1NUFLKnaioiV9871qFLbg08GOg3Tu-60KFr3f9J1BgLM/edit#gid=0
# 上記からSpreadshreetをダウンロード後、tevfileのパスを書き換えて下記のシェルスクリプトを実行する。

f = ARGV[0]
unless f && File.file?(f)
  puts "USAGE: rails runner lib/tasks/import-products.rb tsvfile"
  exit 1
end

updated, inserted = 0, 0
tsv = CSV.read(f,col_sep: "\t", headers: true, encoding: "utf-8")
tsv.each do |row|
  product = Product.find_by(code: row[0])
  size = row[2] == nil ? "" : row[2]
  price = row[3].gsub(",", "")
  if product
    product.update(name: row[1], size: size, price: price, copy: row[4])
    updated += 1
  else
    product = Product.create(code: row[0], name: row[1], size: size, price: price, copy: row[4], user_id: 1)
    inserted += 1
  end
  if product.errors.count > 0
    puts product
    product.errors.messages.values.each { |v| puts v }
  end
end
puts "Insert: #{inserted}, Update: #{updated}"

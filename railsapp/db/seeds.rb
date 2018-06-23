# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

now = Time.now
admin = User.create(name: "Admin", email: "info@lmlab.net", password: "secret", confirmed_at: now)

# The mkdir_p may fail, then run the following command.
# sudo mkdir /var/www/base.lmlab.net && sudo chown vagrant:vagrant /var/www/base.lmlab.net
FileUtils.mkdir_p(PRODUCT_IMAGES_DIR)

if Rails.env == "development"
  d1 = User.create(name: "Distributor1", email: "dist@lmlab.net", password: "secret", confirmed_at: now)
  u1 = User.create(name: "User1", email: "user1@lmlab.net", password: "secret", confirmed_at: now)
  u2 = User.create(name: "User2", email: "user2@lmlab.net", password: "secret", confirmed_at: now)

  Product.create(code: "5050", name: "トリプルＸ（レフィル）", user: admin)
  Product.create(code: "0029", name: "ハーブラスト", user: admin)
  Product.create(code: "0581", name: "ハーブラスト", size: "１０本入り", user: admin)
  Product.create(code: "5070", name: "プロテイン シェーカー", user: admin)
  Product.create(code: "5165", name: "ニュートリ プロテイン （オールプラント）", user: admin)
  Product.create(code: "5910", name: "ニュートリ プロテイン （オールプラント）", size: "お徳用", user: admin)
  Product.create(code: "5441", name: "ＸＳ エナジードリンク エクストラバーン リモンチェッロ パイレーツブラスト", size: "６本入り", user: admin)
  Product.create(code: "5414", name: "ＸＳ エナジードリンク エクストラバーン ミックスベリーブラスト", size: "６本入り", user: admin)
  FileUtils.cp Dir.glob("db/seeds/products/*.*"), PRODUCT_IMAGES_DIR
end

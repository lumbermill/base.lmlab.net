products = Product.all
# give correct directory 
file_names = Dir.new('/var/www/base/uploads/products')

products.each do |product|
    old_f = "/var/www/base/uploads/products/#{product.code}-main.jpg"
    new_f = "/var/www/base/uploads/products/#{product.maker}-#{product.code}-main.jpg"
    next unless File.exists? old_f
    File.rename(old_f, new_f)
end





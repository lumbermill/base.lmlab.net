require 'test_helper'

class ProductTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  test "count " do
    assert_equal 5, Product.count
  end

  test "has_tag" do
    product = products(:one)
    assert product.has_tag? "food"
    assert_not product.has_tag? "detergent"
  end

  test "picture path" do
    path = Product.picture_path(1000,"amway",)
    assert_equal("/products/picture?maker=amway&code=1000&suffix=main",path)
  end

  test "picture real path" do
    path = Product.picture_realpath(1000,"KSY")
    assert_equal("/var/www/base/uploads/products/KSY-1000-main.jpg",path)
  end

end

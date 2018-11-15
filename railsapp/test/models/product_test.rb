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

end

require 'test_helper'

class ProductTagTest < ActiveSupport::TestCase
  test "count " do
    assert_equal 2, ProductTag.count
  end

end

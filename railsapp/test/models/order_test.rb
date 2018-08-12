require 'test_helper'

class OrderTest < ActiveSupport::TestCase
  test "count " do
    assert_equal 2, Order.count
  end
end

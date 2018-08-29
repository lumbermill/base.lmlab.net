require 'test_helper'

class OrderTest < ActiveSupport::TestCase

  test "count " do
    assert_equal 3, Order.count
    assert_equal 0, Order.in_cart.count
    assert_equal 3, Order.ordered.count
    assert_equal 0, Order.shipping.count
    assert_equal 0, Order.arrived.count
    assert_equal 0, Order.canceled.count
  end
end

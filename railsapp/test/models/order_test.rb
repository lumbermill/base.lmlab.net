require 'test_helper'

class OrderTest < ActiveSupport::TestCase

  test "count " do
    assert_equal 7, Order.count
    assert_equal 1, Order.in_cart.count
    assert_equal 3, Order.ordered.count
    assert_equal 1, Order.shipping.count
    assert_equal 1, Order.arrived.count
    assert_equal 1, Order.canceled.count
  end

  test "paper trail test" do
    order = Order.find(1)

    puts order.versions.length
  end

end

require 'test_helper'

class OrderTest < ActiveSupport::TestCase

  test "count " do
    assert_equal 2, Order.count
  end

  test "paper trail test" do
    order = Order.find(1)

    puts order.versions.length
  end

end

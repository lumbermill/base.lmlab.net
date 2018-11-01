require 'test_helper'

class RecentTest < ActiveSupport::TestCase
  test "append" do
    u1 = User.find(1)
    u2 = User.find(2)
    p1 = Product.find(1)
    p2 = Product.find(2)

    assert_equal 2, Recent.count
    Recent.append(u1,p1)
    Recent.append(u2,p1)
    Recent.append(u2,p2)
    Recent.append(u2,p2)
    Recent.append(u2,p1)
    assert_equal 5, Recent.count
  end
end


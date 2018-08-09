require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test "number of children" do
    assert_equal 8, User.count
    # FIXME: The number of admin user's chindren should be 2. But it returns 1..
    assert_equal 2, User.find(1).children.count
    assert_equal 3, User.find(2).children.count
    assert_equal 0, User.find(3).children.count
    assert_equal 1, User.find(4).children.count
  end

end

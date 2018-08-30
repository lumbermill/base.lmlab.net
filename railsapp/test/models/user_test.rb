require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test "number of children" do
    assert_equal 8, User.count
    assert_equal 2, User.find(1).children.count
    assert_equal 3, User.find(2).children.count
    assert_equal 0, User.find(3).children.count
    assert_equal 1, User.find(4).children.count

    assert_equal [2,7], User.find(1).children.map {|c| c.id }
    assert_equal [3,4,6], User.find(2).children.map {|c| c.id }
  end

  test "checkout_histories" do
    u2 = User.find(2)
    o2 = u2.checkout_histories
    assert_equal 0, o2.to_a.count
    assert_equal [3,4,6], u2.children.map {|c| c.id }
    oc2 = u2.checkout_histories_of_children
    assert_equal 6, oc2.to_a.count

    u3 = User.find(3)
    o3 = u3.checkout_histories
    assert_equal 3, o3.to_a.count
    o3.each do |o|
      # NameError: uninitialized constant UserTest::MissingAttributeError
      assert_raises NameError do
        o.user_id
      end
    end

    oc3 = u3.checkout_histories_of_children
    assert_equal [], oc3.to_a
  end
end

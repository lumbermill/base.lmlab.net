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

  test "users4order" do
    # children - distributors + self
    assert_equal 2 - 2 + 1, User.find(1).users4order.count
    assert_equal 3 - 1 + 1, User.find(2).users4order.count
    assert_equal 0 - 0 + 1, User.find(3).users4order.count
    assert_equal 1 - 0 + 1, User.find(4).users4order.count
  end

  test "emoji" do
    u1 = User.create(name: "☀️", email: "user1@lmlab.net", password: "secret", parent: nil, confirmed_at: Time.now)
    assert_equal "☀️", u1.name
  end

  test "recents" do
    u2 = User.find(2)
    assert_equal 0, u2.recent_viewed_products.count

    u3 = User.find(3)
    assert_equal 2, u3.recent_viewed_products.count
  end

  test "parent_by_token" do
    assert_equal 2, User.parent_by_token("dist1").id
  end
end

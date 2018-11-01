require 'test_helper'

class MessageTest < ActiveSupport::TestCase
  test "find_by_user" do
    u1 = User.find(1)
    u2 = User.find(2)
    m = Message.find_by_users(u1,u2)
    assert_equal 2, m.count
  end
end

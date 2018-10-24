require 'test_helper'

class RecentTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  test "count" do
  assert_equal 4, Recent.count
  end

  test "return correct user_id" do
    recent = Recent.find(4)
    assert_equal 3, recent.user_id
  end

end


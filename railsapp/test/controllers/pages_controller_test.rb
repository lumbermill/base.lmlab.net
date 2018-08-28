require 'test_helper'

class PagesControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers
  test "should get root" do
    sign_in users(:dist1)
    # get pages_root_url
    get root_url
    assert_response :success
  end

  test "should get dashboard" do
    sign_in users(:dist1)
    get pages_dashboard_url
    assert_response :success
  end

end

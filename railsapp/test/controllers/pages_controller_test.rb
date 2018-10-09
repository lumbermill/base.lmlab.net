require 'test_helper'

class PagesControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers
  test "should get root" do
    sign_in users(:dist1)
    # get pages_root_url
    get root_url
    assert_response :success
    # anyone can access root page
    sign_out users(:dist1)
    get root_url
    assert_response :success
  end

  test "should get dashboard" do
    sign_in users(:dist1)
    get pages_dashboard_url
    assert_response :success
    #
    sign_out users(:dist1)
    get pages_dashboard_url
    assert_response :found # redirect to sign_in page
  end

  test "should get users" do
    get pages_users_url
    assert_response :found
    sign_in users(:dist1)
    get pages_users_url
    assert_response :success
  end
end

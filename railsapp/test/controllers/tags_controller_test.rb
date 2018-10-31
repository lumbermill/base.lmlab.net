require 'test_helper'

class TagsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers
  setup do
    @tag = tags(:one)
  end

  test "should get index" do
    sign_in users(:dist1)
    get tags_url
    assert_response :success
  end

  test "should get new" do
    sign_in users(:dist1)
    get new_tag_url
    assert_response :success
  end

  test "should create tag" do
    sign_in users(:dist1)
    assert_difference('Tag.count') do
      post tags_url, params: { tag: { code: "dummy", copy: @tag.copy, memo: @tag.memo, name: @tag.name } }
    end

    assert_redirected_to tag_url(Tag.last)
  end

  test "should show tag" do
    sign_in users(:dist1)
    get tag_url(@tag)
    assert_response :success
  end

  test "should get edit" do
    sign_in users(:dist1)
    get edit_tag_url(@tag)
    assert_response :success
  end

  test "should update tag" do
    sign_in users(:dist1)
    patch tag_url(@tag), params: { tag: { code: @tag.code, copy: @tag.copy, memo: @tag.memo, name: @tag.name } }
    assert_redirected_to tag_url(@tag)
  end

  test "should destroy tag" do
    sign_in users(:dist1)
    assert_difference('Tag.count', -1) do
      delete tag_url(@tag)

    end

    assert_redirected_to tags_url
  end
end

require 'test_helper'

class MessagesControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers
  setup do
    sign_in users(:dist1)
    @message = messages(:one)
  end

  test "should get index" do
    get messages_url
    assert_response :success
  end

  test "should get new" do
    get new_message_url
    assert_response :success
  end

  test "should create message" do
    assert_difference('Message.count') do
      post messages_url, params: { message: { body: @message.body, opened: @message.opened, receiver_id: @message.receiver_id, sender_id: @message.sender_id, type: @message.type } }
    end

    assert_redirected_to messages_url(receiver_id: @message.receiver_id)
  end

  test "should show message" do
    get message_url(@message)
    assert_response :success
  end

  test "should get edit" do
    get edit_message_url(@message)
    assert_response 204
  end

  test "should update message" do
    patch message_url(@message), params: { message: { body: @message.body, opened: @message.opened, receiver_id: @message.receiver_id, sender_id: @message.sender_id, type: @message.type } }
    assert_redirected_to message_url(@message)
  end

  test "should destroy message" do
    assert_difference('Message.count', -1) do
      delete message_url(@message)
    end

    assert_redirected_to messages_url
  end
end

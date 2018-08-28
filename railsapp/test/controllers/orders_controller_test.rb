require 'test_helper'

class OrdersControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers
  setup do
    @order = orders(:one)
  end



  test "should get index" do
    sign_in users(:dist1)
    get orders_url
    assert_response :success
  end

  test "should get new" do
    sign_in users(:dist1)
    get new_order_url
    assert_response :success
  end

  test "should create order" do
    sign_in users(:dist1)
    assert_difference('Order.count') do
      post orders_url, params: { order: { quantity: @order.quantity, price: @order.price, product_id: @order.product_id, checkout_at: @order.checkout_at, status: @order.status, user_id: @order.user_id } }
    end

    assert_redirected_to order_url(Order.last)
  end

  test "should show order" do
    sign_in users(:dist1)
    get order_url(@order)
    assert_response :success
  end

  test "should get edit" do
    sign_in users(:dist1)
    get edit_order_url(@order)
    assert_response :success
  end

  test "should update order" do
    sign_in users(:dist1)
    patch order_url(@order), params: { order: { quantity: @order.quantity, product_id: @order.product_id,status: @order.status, user_id: @order.user_id, checkout_at: @order.checkout_at} }
    assert_redirected_to order_url(@order)
  end

  test "should destroy order" do
    sign_in users(:dist1)
    assert_difference('Order.count', -1) do
      delete order_url(@order)
    end

    assert_redirected_to orders_url
  end

end
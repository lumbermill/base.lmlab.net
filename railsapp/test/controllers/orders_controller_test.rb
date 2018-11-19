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
    assert_difference('Order.count', 0) do
      # should not be deleted
      delete order_url(@order)
    end
    assert_redirected_to orders_url

    order_in_cart = orders(:seven)
    assert_difference('Order.count', -1) do
      # should be deleted because it's still in cart.(not be placed)
      delete order_url(order_in_cart)
    end
    assert_redirected_to orders_url
  end

  test "test paper trail update history on order" do
    order = Order.find(1)
    with_versioning do
      previous_versions_count = order.versions.count
      order.price = 50
      order.save
      current_versions_count = order.versions.count
      assert_equal previous_versions_count+1, current_versions_count

    end
  end

  test "test paper trail destroy history on order" do
    order = Order.find(1)

    with_versioning do
      previous_versions_count = order.versions.count
      order.destroy
      current_versions_count = order.versions.count
      assert_equal previous_versions_count+1, current_versions_count
    end
  end

  test "test paper trail create history on order" do

    with_versioning do
      order = Order.create(user_id: 2, product_id: 1)
      puts order.errors.full_messages
      assert_equal 1, order.versions.count
    end
  end

  test "test paper trail whodunnit" do

    order = Order.find(1)
    with_versioning do

      PaperTrail.request.whodunnit = users(:dist1).email
      order.price = 100
      order.save
      assert_equal users(:dist1).email, order.versions.last.whodunnit
    end
  end

  test "test paper trail return previous version on update product" do
    product = Product.find(1)

    with_versioning do
      before_update = product.name
      product.name = 'Changed version'
      product.save
      after_update = product.paper_trail.previous_version.name
      assert_equal before_update, after_update

    end
  end
  #
  test "test paper trail return correct event name on update order" do
    order = Order.find(1)
    order.versions
    with_versioning do
      order.price = 100
      order.save
      v = order.versions.last
      assert 'Update', v.event
    end
  end
  #
  test "test paper trail return correct event name on delete order" do
    order = Order.find(1)
    order.versions
    with_versioning do
      order.destroy
      v = order.versions.last
      assert 'Delete', v.event
    end
  end
  #
  test "test paper trail return correct event name on create order" do
    with_versioning do
      order = Order.create(user_id: 2, product_id: 1)
      order.versions
      v = order.versions.last
      assert 'Create', v.event
    end
  end



end

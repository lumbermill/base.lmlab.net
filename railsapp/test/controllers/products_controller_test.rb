require 'test_helper'

class ProductsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers
  setup do
    @product = products(:one)
  end

  test "should get index" do
    sign_in users(:dist1)
    get products_url
    assert_response :success
  end

  test "should get new" do
    sign_in users(:dist1)
    get new_product_url
    assert_response :success
  end

  test "should create product" do
    sign_in users(:dist1)
    assert_difference('Product.count') do
      post products_url, params: { product: { code: @product.code, copy: @product.copy, cost: @product.cost, maker: @product.maker, memo: @product.memo, name: @product.name, picture_id: @product.picture_id, price: @product.price, size: @product.size, user_id: @product.user_id } }
    end

    assert_redirected_to product_url(Product.last)
  end

  test "should show product" do
    sign_in users(:dist1)
    get product_url(@product)
    assert_response :success
  end

  test "should get edit" do
    sign_in users(:dist1)
    get edit_product_url(@product)
    assert_response :success
  end

  test "should update product" do
    sign_in users(:dist1)
    patch product_url(@product), params: { product: { code: @product.code, copy: @product.copy, cost: @product.cost, maker: @product.maker, memo: @product.memo, name: @product.name, picture_id: @product.picture_id, price: @product.price, size: @product.size, user_id: @product.user_id } }
    assert_redirected_to product_url(@product)
  end

  test "should destroy product" do
    sign_in users(:dist1)
    assert_difference('Product.count', -1) do
      delete product_url(@product)
    end

    assert_redirected_to products_url
  end
end

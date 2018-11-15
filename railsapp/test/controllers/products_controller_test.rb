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
      post products_url, params: { product: { code: 123, copy: @product.copy, cost: @product.cost, maker: @product.maker, memo: @product.memo, name: @product.name, picture_id: @product.picture_id, price: @product.price, size: @product.size, user_id: @product.user_id } }
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
    # TODO: we have to think which one can destroy. (we should not destroy the one which is in-cart.)
    assert_difference('Product.count', -1) do
      delete product_url(@product)
    end

    assert_redirected_to products_url
  end

  test "test paper trail update history on product" do
    product = Product.find(1)
    with_versioning do
      previous_versions_count = product.versions.count
      product.name = 'MyStrings'
      product.save
      current_versions_count = product.versions.count
      assert_equal previous_versions_count+1, current_versions_count
    end
  end

  test "test paper trail destroy history on product" do
    product = Product.find(1)
    product_tag = ProductTag.find_by(product: product)
    product_tag.destroy

    with_versioning do
      previous_versions_count = product.versions.count
      product.destroy
      current_versions_count = product.versions.count
      assert_equal previous_versions_count+1, current_versions_count
    end
  end

  test "test paper trail create history on product" do

    with_versioning do

      product = Product.create(user_id: 2, name: 'New Name')
      puts product.errors.full_messages
      assert_equal 1, product.versions.count
    end
  end

  test "test paper trail whodunnit" do
    # sign_in users(:dist1)
    product = Product.find(1)
    with_versioning do

      PaperTrail.request.whodunnit = users(:dist1).email
      product.name = 'Mystring'
      product.save
      assert_equal users(:dist1).email, product.versions.last.whodunnit
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

  test "test paper trail return correct event name on update product" do
    product = Product.find(1)
    product.versions
    with_versioning do
      product.name = 'Changed version'
      product.save
      v = product.versions.last
      assert 'Update', v.event
    end
  end

  test "test paper trail return correct event name on delete product" do
    product = Product.find(1)
    product_tag = ProductTag.find_by(product: product)
    product_tag.destroy
    product.versions
    with_versioning do
      product.destroy
      v = product.versions.last
      assert 'Delete', v.event
    end
  end

  test "test paper trail return correct event name on create product" do
    with_versioning do
      product = Product.create(user_id: 2, name: 'New Name')
      product.versions
      v = product.versions.last
      assert 'Create', v.event
    end
  end

  test "product code can not be nil" do
    sign_in users(:dist1)
    assert_not_nil(@product.code)
  end

  test "product code must be unique" do
    sign_in users(:dist1)
    duplicate_code = @product.dup
    assert_not duplicate_code.valid?
  end

  test "product should have name" do
    sign_in users(:dist1)
    assert_not_nil(@product.name)

  end

  test "price precision test" do
    sign_in users(:dist1)
    assert_match(/\A[0-9,]+\z/, @product.price.to_s,"Matched with the regular expression")

  end



end

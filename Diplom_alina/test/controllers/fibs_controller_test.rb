require 'test_helper'

class FibsControllerTest < ActionController::TestCase
  setup do
    @fib = fibs(:one)
  end

  test "should get new" do
    get :new
    assert_response :success
    assert_not_nil assigns(:fibs)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create fib" do
    assert_difference('Fib.count') do
      post :create, fib: { belong_to: @fib.belong_to }
    end

    assert_redirected_to fib_path(assigns(:fib))
  end

  test "should show fib" do
    get :show, id: @fib
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @fib
    assert_response :success
  end

  test "should update fib" do
    patch :update, id: @fib, fib: { belong_to: @fib.belong_to }
    assert_redirected_to fib_path(assigns(:fib))
  end

  test "should destroy fib" do
    assert_difference('Fib.count', -1) do
      delete :destroy, id: @fib
    end

    assert_redirected_to fibs_path
  end
end

require 'test_helper'

class SubdivisionsControllerTest < ActionController::TestCase
  setup do
    @subdivision = subdivisions(:one)
  end

  test "should get new" do
    get :new
    assert_response :success
    assert_not_nil assigns(:subdivisions)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create subdivision" do
    assert_difference('Subdivision.count') do
      post :create, subdivision: { type_num: @subdivision.type_num, type_title: @subdivision.type_title }
    end

    assert_redirected_to subdivision_path(assigns(:subdivision))
  end

  test "should show subdivision" do
    get :show, id: @subdivision
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @subdivision
    assert_response :success
  end

  test "should update subdivision" do
    patch :update, id: @subdivision, subdivision: { type_num: @subdivision.type_num, type_title: @subdivision.type_title }
    assert_redirected_to subdivision_path(assigns(:subdivision))
  end

  test "should destroy subdivision" do
    assert_difference('Subdivision.count', -1) do
      delete :destroy, id: @subdivision
    end

    assert_redirected_to subdivisions_path
  end
end

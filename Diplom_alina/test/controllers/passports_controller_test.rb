require 'test_helper'

class PassportsControllerTest < ActionController::TestCase
  setup do
    @passport = passports(:one)
  end

  test "should get new" do
    get :new
    assert_response :success
    assert_not_nil assigns(:passports)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create passport" do
    assert_difference('Passport.count') do
      post :create, passport: { code_subdivision: @passport.code_subdivision, date_extradition: @passport.date_extradition, number: @passport.number, passport_issued: @passport.passport_issued, series: @passport.series }
    end

    assert_redirected_to passport_path(assigns(:passport))
  end

  test "should show passport" do
    get :show, id: @passport
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @passport
    assert_response :success
  end

  test "should update passport" do
    patch :update, id: @passport, passport: { code_subdivision: @passport.code_subdivision, date_extradition: @passport.date_extradition, number: @passport.number, passport_issued: @passport.passport_issued, series: @passport.series }
    assert_redirected_to passport_path(assigns(:passport))
  end

  test "should destroy passport" do
    assert_difference('Passport.count', -1) do
      delete :destroy, id: @passport
    end

    assert_redirected_to passports_path
  end
end

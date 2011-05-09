require 'test_helper'

class FugasControllerTest < ActionController::TestCase
  setup do
    @fuga = fugas(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:fugas)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create fuga" do
    assert_difference('Fuga.count') do
      post :create, :fuga => @fuga.attributes
    end

    assert_redirected_to fuga_path(assigns(:fuga))
  end

  test "should show fuga" do
    get :show, :id => @fuga.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @fuga.to_param
    assert_response :success
  end

  test "should update fuga" do
    put :update, :id => @fuga.to_param, :fuga => @fuga.attributes
    assert_redirected_to fuga_path(assigns(:fuga))
  end

  test "should destroy fuga" do
    assert_difference('Fuga.count', -1) do
      delete :destroy, :id => @fuga.to_param
    end

    assert_redirected_to fugas_path
  end
end

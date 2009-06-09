require 'test_helper'

class GoalsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:goals)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create goals" do
    assert_difference('Goals.count') do
      post :create, :goals => { }
    end

    assert_redirected_to goals_path(assigns(:goals))
  end

  test "should show goals" do
    get :show, :id => goals(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => goals(:one).to_param
    assert_response :success
  end

  test "should update goals" do
    put :update, :id => goals(:one).to_param, :goals => { }
    assert_redirected_to goals_path(assigns(:goals))
  end

  test "should destroy goals" do
    assert_difference('Goals.count', -1) do
      delete :destroy, :id => goals(:one).to_param
    end

    assert_redirected_to goals_path
  end
end

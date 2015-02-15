require 'test_helper'

class SessionPlansControllerTest < ActionController::TestCase
  setup do
    @session_plan = session_plans(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:session_plans)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create session_plan" do
    assert_difference('SessionPlan.count') do
      post :create, session_plan: {  }
    end

    assert_redirected_to session_plan_path(assigns(:session_plan))
  end

  test "should show session_plan" do
    get :show, id: @session_plan
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @session_plan
    assert_response :success
  end

  test "should update session_plan" do
    patch :update, id: @session_plan, session_plan: {  }
    assert_redirected_to session_plan_path(assigns(:session_plan))
  end

  test "should destroy session_plan" do
    assert_difference('SessionPlan.count', -1) do
      delete :destroy, id: @session_plan
    end

    assert_redirected_to session_plans_path
  end
end

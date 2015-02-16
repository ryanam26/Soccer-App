require 'test_helper'

class SessionPlanCategoriesControllerTest < ActionController::TestCase
  setup do
    @session_plan_category = session_plan_categories(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:session_plan_categories)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create session_plan_category" do
    assert_difference('SessionPlanCategory.count') do
      post :create, session_plan_category: {  }
    end

    assert_redirected_to session_plan_category_path(assigns(:session_plan_category))
  end

  test "should show session_plan_category" do
    get :show, id: @session_plan_category
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @session_plan_category
    assert_response :success
  end

  test "should update session_plan_category" do
    patch :update, id: @session_plan_category, session_plan_category: {  }
    assert_redirected_to session_plan_category_path(assigns(:session_plan_category))
  end

  test "should destroy session_plan_category" do
    assert_difference('SessionPlanCategory.count', -1) do
      delete :destroy, id: @session_plan_category
    end

    assert_redirected_to session_plan_categories_path
  end
end

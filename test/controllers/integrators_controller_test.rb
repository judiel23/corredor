require 'test_helper'

class IntegratorsControllerTest < ActionController::TestCase
  setup do
    @integrator = integrators(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:integrators)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create integrator" do
    assert_difference('Integrator.count') do
      post :create, integrator: {  }
    end

    assert_redirected_to integrator_path(assigns(:integrator))
  end

  test "should show integrator" do
    get :show, id: @integrator
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @integrator
    assert_response :success
  end

  test "should update integrator" do
    patch :update, id: @integrator, integrator: {  }
    assert_redirected_to integrator_path(assigns(:integrator))
  end

  test "should destroy integrator" do
    assert_difference('Integrator.count', -1) do
      delete :destroy, id: @integrator
    end

    assert_redirected_to integrators_path
  end
end

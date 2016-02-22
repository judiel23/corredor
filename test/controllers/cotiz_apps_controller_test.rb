require 'test_helper'

class CotizAppsControllerTest < ActionController::TestCase
  setup do
    @cotiz_app = cotiz_apps(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:cotiz_apps)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create cotiz_app" do
    assert_difference('CotizApp.count') do
      post :create, cotiz_app: { birthday: @cotiz_app.birthday, discount_rate: @cotiz_app.discount_rate, dni_number: @cotiz_app.dni_number, dni_type: @cotiz_app.dni_type, email: @cotiz_app.email, intermediate_code: @cotiz_app.intermediate_code, kilometer_zero: @cotiz_app.kilometer_zero, lastname: @cotiz_app.lastname, local_code_area: @cotiz_app.local_code_area, local_phone: @cotiz_app.local_phone, marital_status: @cotiz_app.marital_status, movil_code_area: @cotiz_app.movil_code_area, movil_phone: @cotiz_app.movil_phone, name: @cotiz_app.name, plan_code: @cotiz_app.plan_code, plan_review: @cotiz_app.plan_review, sex: @cotiz_app.sex, state: @cotiz_app.state, vehicle_brand: @cotiz_app.vehicle_brand, vehicle_model: @cotiz_app.vehicle_model, vehicle_type: @cotiz_app.vehicle_type, vehicle_use: @cotiz_app.vehicle_use, vehicle_version: @cotiz_app.vehicle_version, vehicle_year: @cotiz_app.vehicle_year }
    end

    assert_redirected_to cotiz_app_path(assigns(:cotiz_app))
  end

  test "should show cotiz_app" do
    get :show, id: @cotiz_app
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @cotiz_app
    assert_response :success
  end

  test "should update cotiz_app" do
    patch :update, id: @cotiz_app, cotiz_app: { birthday: @cotiz_app.birthday, discount_rate: @cotiz_app.discount_rate, dni_number: @cotiz_app.dni_number, dni_type: @cotiz_app.dni_type, email: @cotiz_app.email, intermediate_code: @cotiz_app.intermediate_code, kilometer_zero: @cotiz_app.kilometer_zero, lastname: @cotiz_app.lastname, local_code_area: @cotiz_app.local_code_area, local_phone: @cotiz_app.local_phone, marital_status: @cotiz_app.marital_status, movil_code_area: @cotiz_app.movil_code_area, movil_phone: @cotiz_app.movil_phone, name: @cotiz_app.name, plan_code: @cotiz_app.plan_code, plan_review: @cotiz_app.plan_review, sex: @cotiz_app.sex, state: @cotiz_app.state, vehicle_brand: @cotiz_app.vehicle_brand, vehicle_model: @cotiz_app.vehicle_model, vehicle_type: @cotiz_app.vehicle_type, vehicle_use: @cotiz_app.vehicle_use, vehicle_version: @cotiz_app.vehicle_version, vehicle_year: @cotiz_app.vehicle_year }
    assert_redirected_to cotiz_app_path(assigns(:cotiz_app))
  end

  test "should destroy cotiz_app" do
    assert_difference('CotizApp.count', -1) do
      delete :destroy, id: @cotiz_app
    end

    assert_redirected_to cotiz_apps_path
  end
end

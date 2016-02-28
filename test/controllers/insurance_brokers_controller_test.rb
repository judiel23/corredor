require 'test_helper'

class InsuranceBrokersControllerTest < ActionController::TestCase
  setup do
    @insurance_broker = insurance_brokers(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:insurance_brokers)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create insurance_broker" do
    assert_difference('InsuranceBroker.count') do
      post :create, insurance_broker: { discount_rate: @insurance_broker.discount_rate, insurance: @insurance_broker.insurance, intermediary_code: @insurance_broker.intermediary_code, plan_code: @insurance_broker.plan_code, plan_review: @insurance_broker.plan_review, users_id: @insurance_broker.users_id }
    end

    assert_redirected_to insurance_broker_path(assigns(:insurance_broker))
  end

  test "should show insurance_broker" do
    get :show, id: @insurance_broker
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @insurance_broker
    assert_response :success
  end

  test "should update insurance_broker" do
    patch :update, id: @insurance_broker, insurance_broker: { discount_rate: @insurance_broker.discount_rate, insurance: @insurance_broker.insurance, intermediary_code: @insurance_broker.intermediary_code, plan_code: @insurance_broker.plan_code, plan_review: @insurance_broker.plan_review, users_id: @insurance_broker.users_id }
    assert_redirected_to insurance_broker_path(assigns(:insurance_broker))
  end

  test "should destroy insurance_broker" do
    assert_difference('InsuranceBroker.count', -1) do
      delete :destroy, id: @insurance_broker
    end

    assert_redirected_to insurance_brokers_path
  end
end

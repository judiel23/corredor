require 'test_helper'

class CorredorsControllerTest < ActionController::TestCase
  setup do
    @corredor = corredors(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:corredors)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create corredor" do
    assert_difference('Corredor.count') do
      post :create, corredor: { anio: @corredor.anio, apellido: @corredor.apellido, ced: @corredor.ced, cedula: @corredor.cedula, celular: @corredor.celular, cod1: @corredor.cod1, cod2: @corredor.cod2, dia: @corredor.dia, email: @corredor.email, estado: @corredor.estado, fnacimiento: @corredor.fnacimiento, informacion: @corredor.informacion, marca: @corredor.marca, mes: @corredor.mes, modelo: @corredor.modelo, nacion: @corredor.nacion, nombre: @corredor.nombre, poliza: @corredor.poliza, sexo: @corredor.sexo, tcelular: @corredor.tcelular, telefono: @corredor.telefono, tfijo: @corredor.tfijo, version: @corredor.version, year: @corredor.year, zona: @corredor.zona }
    end

    assert_redirected_to corredor_path(assigns(:corredor))
  end

  test "should show corredor" do
    get :show, id: @corredor
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @corredor
    assert_response :success
  end

  test "should update corredor" do
    patch :update, id: @corredor, corredor: { anio: @corredor.anio, apellido: @corredor.apellido, ced: @corredor.ced, cedula: @corredor.cedula, celular: @corredor.celular, cod1: @corredor.cod1, cod2: @corredor.cod2, dia: @corredor.dia, email: @corredor.email, estado: @corredor.estado, fnacimiento: @corredor.fnacimiento, informacion: @corredor.informacion, marca: @corredor.marca, mes: @corredor.mes, modelo: @corredor.modelo, nacion: @corredor.nacion, nombre: @corredor.nombre, poliza: @corredor.poliza, sexo: @corredor.sexo, tcelular: @corredor.tcelular, telefono: @corredor.telefono, tfijo: @corredor.tfijo, version: @corredor.version, year: @corredor.year, zona: @corredor.zona }
    assert_redirected_to corredor_path(assigns(:corredor))
  end

  test "should destroy corredor" do
    assert_difference('Corredor.count', -1) do
      delete :destroy, id: @corredor
    end

    assert_redirected_to corredors_path
  end
end

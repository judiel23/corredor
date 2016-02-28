require 'test_helper'

class FormUniSegurosControllerTest < ActionController::TestCase
  setup do
    @form_uni_seguro = form_uni_seguros(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:form_uni_seguros)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create form_uni_seguro" do
    assert_difference('FormUniSeguro.count') do
      post :create, form_uni_seguro: { anoveh: @form_uni_seguro.anoveh, codareacel: @form_uni_seguro.codareacel, codarealocal: @form_uni_seguro.codarealocal, codedocivil: @form_uni_seguro.codedocivil, codestado: @form_uni_seguro.codestado, codinter: @form_uni_seguro.codinter, codmarca: @form_uni_seguro.codmarca, codmodelo: @form_uni_seguro.codmodelo, codplan: @form_uni_seguro.codplan, codsexo: @form_uni_seguro.codsexo, codversion: @form_uni_seguro.codversion, desapellido: @form_uni_seguro.desapellido, desnombre: @form_uni_seguro.desnombre, email: @form_uni_seguro.email, fecnac: @form_uni_seguro.fecnac, numtelefcel: @form_uni_seguro.numtelefcel, numtelefonolocal: @form_uni_seguro.numtelefonolocal, porcdcto: @form_uni_seguro.porcdcto, revplan: @form_uni_seguro.revplan, rif: @form_uni_seguro.rif }
    end

    assert_redirected_to form_uni_seguro_path(assigns(:form_uni_seguro))
  end

  test "should show form_uni_seguro" do
    get :show, id: @form_uni_seguro
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @form_uni_seguro
    assert_response :success
  end

  test "should update form_uni_seguro" do
    patch :update, id: @form_uni_seguro, form_uni_seguro: { anoveh: @form_uni_seguro.anoveh, codareacel: @form_uni_seguro.codareacel, codarealocal: @form_uni_seguro.codarealocal, codedocivil: @form_uni_seguro.codedocivil, codestado: @form_uni_seguro.codestado, codinter: @form_uni_seguro.codinter, codmarca: @form_uni_seguro.codmarca, codmodelo: @form_uni_seguro.codmodelo, codplan: @form_uni_seguro.codplan, codsexo: @form_uni_seguro.codsexo, codversion: @form_uni_seguro.codversion, desapellido: @form_uni_seguro.desapellido, desnombre: @form_uni_seguro.desnombre, email: @form_uni_seguro.email, fecnac: @form_uni_seguro.fecnac, numtelefcel: @form_uni_seguro.numtelefcel, numtelefonolocal: @form_uni_seguro.numtelefonolocal, porcdcto: @form_uni_seguro.porcdcto, revplan: @form_uni_seguro.revplan, rif: @form_uni_seguro.rif }
    assert_redirected_to form_uni_seguro_path(assigns(:form_uni_seguro))
  end

  test "should destroy form_uni_seguro" do
    assert_difference('FormUniSeguro.count', -1) do
      delete :destroy, id: @form_uni_seguro
    end

    assert_redirected_to form_uni_seguros_path
  end
end

# encoding 'utf-8'
class IntegratorsController < ApplicationController
  before_action :set_integrator, only: [:show, :edit, :update, :destroy]
  before_action :set_cotiz_app,  only: [:generic_quotation]
  # GET /integrators
  # GET /integrators.json
  def index

  end

  # GET /integrators/1
  # GET /integrators/1.json
  def show
  end

  # GET /integrators/new
  def new

  end

  # GET /integrators/1/edit
  def edit
  end

  # POST /integrators
  # POST /integrators.json
  def create

  end

  # PATCH/PUT /integrators/1
  # PATCH/PUT /integrators/1.json
  def update

  end

  # DELETE /integrators/1
  # DELETE /integrators/1.json
  def destroy

  end

  # POST /integrators
  # POST /integrators.json
  def generic_quotation
    @cotizacion = []
    @resultset  = ""
    case params[:aseguradora].to_sym
      when :universitas
        @resultset = Integrator::call_cotizar_universitas_auto(params)
        parse_result = UniversitasConsumer::parse(@resultset)
        @cotizacion.push(JSON.parse(out_prepare(@resultset)))
      when :vivir
        @resultset = Integrator::call_cotizar_vivir_auto(params)
        parse_result = VivirSegurosConsumer::parse(@resultset)
        @cotizacion.push(JSON.parse(@resultset))
      when :oriental
        @resultset = Integrator::call_cotizar_oriental_auto(params).to_s.force_encoding("ISO-8859-1").encode("UTF-8")
        parse_result = OrientalConsumer::parse(@resultset)
        @cotizacion.push(JSON.parse(@resultset))
      when :ibero
        @resultset = Integrator::call_cotizar_ibero_auto(params)
        parse_result = IberoSegurosConsumer::parse(@resultset)
        @cotizacion.push(JSON.parse(@resultset))
      when :estar
        @resultset = Integrator::call_cotizar_estar_auto(params)
        parse_result = EstarConsumer::parse(@resultset)
        @cotizacion.push(JSON.parse(@resultset))
      when :sumaAseguradaIbero
        @resultset = Integrator::call_sumaAsegurada_ibero(params)
      #  parse_result = IberoSegurosSuma::parse(@resultset)
        @cotizacion.push(JSON.parse(@resultset))
    else
    end
    # Auditando Respuestas...
    #InsuranceResponse.create!(insurance: params[:aseguradora], cotiz_app: @cotiz_app, response: @resultset)
    if params[:aseguradora].to_sym != :sumaAseguradaIbero
      parse_result[:corredor_id] = @cotiz_app.id
    end
    InsuranceResponse.create!(insurance: params[:aseguradora], cotiz_app_id: @cotiz_app.id, response: @resultset)
    Report.create(parse_result)
    render json: @cotizacion
  end

  def out_prepare(resulset)
    resulset.to_s.force_encoding("ISO-8859-1").encode("UTF-8")
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_integrator

    end

    def set_cotiz_app
      #@cotiz_app = CotizApp.find(params[:object_id])
      @cotiz_app = Corredor.find(params[:object_id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def integrator_params
      params[:integrator]
    end
end

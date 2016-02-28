class CotizAppsController < ApplicationController
  before_action :set_cotiz_app, only: [:show, :edit, :update, :destroy]

  # GET /cotiz_apps
  # GET /cotiz_apps.json
  def index
    @cotiz_apps = CotizApp.all
  end

  # GET /cotiz_apps/1
  # GET /cotiz_apps/1.json
  def show
    @marca   = Make.find_by(:code => @cotiz_app.vehicle_brand).make
    @modelo  = Vehicle.find_by(:make => @cotiz_app.vehicle_brand, :code => @cotiz_app.vehicle_model).model
    @version = Version.find_by(:make => @cotiz_app.vehicle_brand, :model => @cotiz_app.vehicle_model, :code => @cotiz_app.vehicle_version).version
    
    
    @universitas = JSON.parse(InsuranceResponse.where(:cotiz_app_id => @cotiz_app.id, :insurance => "universitas").last.response) rescue []
    @vivir       = JSON.parse(InsuranceResponse.where(:cotiz_app_id => @cotiz_app.id, :insurance => "vivir").last.response) rescue []
    @estar       = JSON.parse(InsuranceResponse.where(:cotiz_app_id => @cotiz_app.id, :insurance => "estar").last.response) rescue []
    @oriental    = JSON.parse(InsuranceResponse.where(:cotiz_app_id => @cotiz_app.id, :insurance => "oriental").last.response) rescue []
    @ibero       = JSON.parse(InsuranceResponse.where(:cotiz_app_id => @cotiz_app.id, :insurance => "ibero").last.response) rescue []

    respond_to do |format|
      format.html
      format.pdf do
        send_data ReportPdf.new(@cotiz_app).render, filename: "cotizacion_#{@cotiz_app.id}.pdf", type: "application/pdf", disposition: "inline"
      end
      format.xlsx { render xlsx: 'show', filename: "show.xlsx"}
      format.json { render json: @cotiz_app }
    end
  end
  
  # GET /cotiz_apps/new
  def new
    @cotiz_app = CotizApp.new
  end

  # GET /cotiz_apps/1/edit
  def edit
  end

  # POST /cotiz_apps
  # POST /cotiz_apps.json
  def create
    @cotiz_app = CotizApp.new(cotiz_app_params)

    respond_to do |format|
      if @cotiz_app.save
        format.html { redirect_to  cotiz_app_path(@cotiz_app), notice: 'Cotiz app was successfully created.' }
        format.json { render :show, status: :created, location: @cotiz_app }
      else
        format.html { render :new }
        format.json { render json: @cotiz_app.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /cotiz_apps/1
  # PATCH/PUT /cotiz_apps/1.json
  def update
    respond_to do |format|
      if @cotiz_app.update(cotiz_app_params)
        format.html { redirect_to @cotiz_app, notice: 'Cotiz app was successfully updated.' }
        format.json { render :show, status: :ok, location: @cotiz_app }
      else
        format.html { render :edit }
        format.json { render json: @cotiz_app.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /cotiz_apps/1
  # DELETE /cotiz_apps/1.json
  def destroy
    @cotiz_app.destroy
    respond_to do |format|
      format.html { redirect_to cotiz_apps_url, notice: 'Cotiz app was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_cotiz_app
      @cotiz_app = CotizApp.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def cotiz_app_params
      params.require(:cotiz_app).permit(:name, :lastname, :dni_type, :dni_number, :local_code_area, :local_phone, :movil_code_area, :movil_phone, :birthday, :marital_status, :sex, :email, :vehicle_year, :vehicle_brand, :vehicle_model, :vehicle_version, :plaque, :intermediate_code, :state, :plan_code, :plan_review, :discount_rate, :vehicle_use, :kilometer_zero, :vehicle_type)
    end
end

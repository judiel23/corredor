# encoding 'utf-8'
class FormUniSegurosController < ApplicationController
  before_action :set_form_uni_seguro, only: [:show, :edit, :update, :destroy]
  
  # GET /form_uni_seguros
  # GET /form_uni_seguros.json
  def index
    @form_uni_seguros = FormUniSeguro.all
  end

  # GET /form_uni_seguros/1
  # GET /form_uni_seguros/1.json
  def show
  end

  # GET /form_uni_seguros/new
  def new
    @form_uni_seguro = FormUniSeguro.new
  end

  # GET /form_uni_seguros/1/edit
  def edit
  end

  # POST /form_uni_seguros
  # POST /form_uni_seguros.json
  def create
    @cotizacion = UniversitasConsumer::cotizar_automovil(form_uni_seguro_params) rescue nil
    convertir   = @cotizacion.to_s.force_encoding("ISO-8859-1").encode("UTF-8")
    # menu.to_s.encode('UTF-8', {:invalid => :replace, :undef => :replace, :replace => '?'})
    respond_to do |format|
      format.html { redirect_to  form_uni_seguros_path, notice: "Parametros #{convertir}".to_s } #{JSON.parse(@cotizacion)}
    end
    %#
    @form_uni_seguro = FormUniSeguro.new(form_uni_seguro_params)

    respond_to do |format|
      if @form_uni_seguro.save
        format.html { redirect_to @form_uni_seguro, notice: 'Form uni seguro was successfully created.' }
        format.json { render :show, status: :created, location: @form_uni_seguro }
      else
        format.html { render :new }
        format.json { render json: @form_uni_seguro.errors, status: :unprocessable_entity }
      end
    end
    #
  end

  # PATCH/PUT /form_uni_seguros/1
  # PATCH/PUT /form_uni_seguros/1.json
  def update
    respond_to do |format|
      if @form_uni_seguro.update(form_uni_seguro_params)
        format.html { redirect_to @form_uni_seguro, notice: 'Form uni seguro was successfully updated.' }
        format.json { render :show, status: :ok, location: @form_uni_seguro }
      else
        format.html { render :edit }
        format.json { render json: @form_uni_seguro.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /form_uni_seguros/1
  # DELETE /form_uni_seguros/1.json
  def destroy
    @form_uni_seguro.destroy
    respond_to do |format|
      format.html { redirect_to form_uni_seguros_url, notice: 'Form uni seguro was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
  
  def integrador
    
  end
  
  def get_marcas_by_anio
    render json: JSON.parse(UniversitasConsumer::get_marcas(params[:anio]))["pcursor"].first rescue []
  end
  
  def get_modelo_vehicle
    #render json: JSON.parse(UniversitasConsumer::get_modelo(params[:anio], params[:marca]))["pcursor"].first rescue []
    render json: Vehicle.where(:make => params[:marca]).collect { |model| {codmodelo: model.code, descmodelo: model.model} }
  end
  
  def get_version_automv
    #render json: JSON.parse(UniversitasConsumer::get_version(params[:anio], params[:marca], params[:modelo]))["pcursor"].first rescue []
    render json: Version.where(:make => params[:marca], :model => params[:modelo]).map { |version| { codversion: version.code, descversion: version.version} }
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_form_uni_seguro
      @form_uni_seguro = FormUniSeguro.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def form_uni_seguro_params
      params.require(:form_uni_seguro).permit(:desnombre, :desapellido, :rif, :codarealocal, :numtelefonolocal, :codareacel, :numtelefcel, :fecnac, :codedocivil, :codsexo, :email, :codmarca, :codmodelo, :codversion, :anoveh, :codinter, :codestado, :codplan, :revplan, :porcdcto)
    end
end

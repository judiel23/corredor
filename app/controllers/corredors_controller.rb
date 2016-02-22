class CorredorsController < ApplicationController
  before_action :set_corredor, only: [:show, :edit, :update, :destroy]

  # GET /corredors
  # GET /corredors.json
  def index
    @corredors = Corredor.all
  end

  # POST /corredors
  # POST /corredors.json
  def modelo
    @corredor = Corredor.find_by_id(params[:id])
    @corredor.update(corredor_params)
    render :action=>'year', :id=>'@corredor.id', notice: 'Modelo was successfully created.'

  end

  def year
    @corredor = Corredor.find_by_id(params[:id])
    @corredor.update(corredor_params)
    render :action=>'version', :id=>'@corredor.id', notice: "Year Added Successfully"
  end

  def version
    @corredor = Corredor.find_by_id(params[:id])
    @corredor.update(corredor_params)
    render :action=>'placa', :id=>'@corredor.id', notice: "Version Added Successfully"
  end

  def placa
    @corredor = Corredor.find_by_id(params[:id])
    @corredor.update(corredor_params)
    render :action=>'features', :id=>'@corredor.id', notice: "Placa Added Successfully"
  end

  def features
    @corredor = Corredor.find_by_id(params[:id])
    @corredor.update(corredor_params)
    render :action=>'zona', :id=>'@corredor.id', notice: "Features Added Successfully"
  end

  def zona
    @corredor = Corredor.find_by_id(params[:id])
    @corredor.update(corredor_params)
    render :action=>'cedula', :id=>'@corredor.id', notice: "Zona Added Successfully"
  end

  def poliza
    @corredor = Corredor.find_by_id(params[:id])
    @corredor.update(corredor_params)
    render :action=>'cedula', :id=>'@corredor.id', notice: "Poliza Added Successfully"
  end

  def cedula
    @corredor = Corredor.find_by_id(params[:id])
    @corredor.update(corredor_params)
    render :action=>'nombre', :id=>'@corredor.id', notice: "Cedula Added Successfully"
  end

  def nombre
    @corredor = Corredor.find_by_id(params[:id])
    @corredor.update(corredor_params)
    render :action=>'sexo', :id=>'@corredor.id', notice: "Nombre Added Successfully"
  end


  def sexo
    @corredor = Corredor.find_by_id(params[:id])
    if @corredor.nil?
      render :action=>'show'
    else
      @corredor.update(corredor_params)
      render :action=>'email', :id=>'@corredor.id', notice: "Sexo Added Successfully"
    end
  end

  def email
    @corredor = Corredor.find_by_id(params[:id])
    @corredor.update(corredor_params)
    render :action=>'estado', :id=>'@corredor.id', notice: "Correo Added Successfully"
  end

  def estado
    @corredor = Corredor.find_by_id(params[:id])
    @corredor.update(corredor_params)
    render :action=>'fnacimiento', :id=>'@corredor.id', notice: "Estado Added Successfully"
  end

  def fnacimiento
    @corredor = Corredor.find_by_id(params[:id])
    @corredor.update(corredor_params)
    render :action=>'tfijo', :id=>'@corredor.id', notice: "Fecha de Nacimiento Added Successfully"
  end

  def tfijo
    @corredor = Corredor.find_by_id(params[:id])
    @corredor.update(corredor_params)
    render :action=>'tcelular', :id=>'@corredor.id', notice: "Telefono fijo Added Successfully"
  end

  def tcelular
    @corredor = Corredor.find_by_id(params[:id])
    @corredor.update(corredor_params)
    render :action=>'show', :id=>'@corredor.id', notice: "informacion Added Successfully"
  end

  def ibero_sum
    @corredor = Corredor.find_by_id(params[:id])
    @corredor.update(corredor_params)
    render :action=>'show', :id=>'@corredor.id', notice: "Added Successfully"
  end

   def informacion
    @corredor = Corredor.find_by_id(params[:id])
    @corredor.update(corredor_params)
    redirect_to corredor_path(@corredor), notice: "informacion Added Successfully"
  end



  def consulta
    @corredor = Corredor.find_by_id(params[:id])

    @universitas = Report.where(:corredor_id => @corredor.id, :insurance => "universitas").last
    if(@universitas.blank?)
        @universitas = Report.new
        @universitas.status = 0
    end
    @vivir = Report.where(:corredor_id => @corredor.id, :insurance => "vivir").last
    if(@vivir.blank?)
        @vivir = Report.new
        @vivir.status = 0
    end
    @oriental = Report.where(:corredor_id => @corredor.id, :insurance => "oriental").last
    if(@oriental.blank?)
        @oriental = Report.new
        @oriental.status = 0
    end
    @ibero = Report.where(:corredor_id => @corredor.id, :insurance => "ibero").last
    if(@ibero.blank?)
        @ibero = Report.new
        @ibero.status = 0
    end
    @estar = Report.where(:corredor_id => @corredor.id, :insurance => "estar").last
    if(@estar.blank?)
        @estar = Report.new
        @estar.status = 0
    end
    dob = Date.strptime( @corredor.fnacimiento, '%d/%m/%Y' )
    now = Time.now.utc.to_date
    @age = now.year - dob.year - ((now.month > dob.month || (now.month == dob.month && now.day >= dob.day)) ? 0 : 1)

  end

  def add_versionList
    
    @corredor = Corredor.find_by_id(params[:id])
    @oriental = Report.where(:corredor_id => @corredor.id, :insurance => "oriental").last
    if(@oriental.blank?)
        @oriental = Report.new
        @oriental.status = 0
    end

    version_list = params[:user]
    @oriental.versionList = version_list
    @oriental.save   
    render :nothing => true
  end

  def add_actualCoti
    
    @corredor = Corredor.find_by_id(params[:id])
    @oriental = Report.where(:corredor_id => @corredor.id, :insurance => "oriental").last
    if(@oriental.blank?)
        @oriental = Report.new
        @oriental.status = 0
    end


    actualCoti = params[:user]
    @oriental.actualCoti = actualCoti
    @oriental.save   
    render :nothing => true
  end

  # GET /corredors/1
  # GET /corredors/1.json
  def show
    puts params
    respond_to do |format|
      format.html
      format.pdf do
        send_data ReportPdf.new(@corredor).render, filename: "cotizacion_#{@corredor.id}.pdf", type: "application/pdf", disposition: "inline"
      end
      format.xlsx { render xlsx: 'show', filename: "cotizacion_#{@corredor.id}.xlsx"}
      format.json { render json: @cotiz_app }
    end

  end

  # GET /corredors/new
  def new
    @corredor = Corredor.new
  end

  # GET /corredors/1/edit
  def edit
    @corredor = Corredor.find(params[:id])
    make = @corredor.marca
    @aux = Vehicle.where(make: make)
  end

  # POST /corredors
  # POST /corredors.json
  def create
    @corredor = Corredor.new(corredor_params)

    respond_to do |format|
      if @corredor.save
        format.html { render :action=>'modelo', :id=>'@corredor.id', notice: 'Corredor was successfully created.' }
        format.json { render :modelo, status: :created, location: @corredor_modelo}
      else
        format.html { render :new }
        format.json { render json: @corredor.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /corredors/1
  # PATCH/PUT /corredors/1.json
  def update
    respond_to do |format|
      if @corredor.update(corredor_params)
        format.html { redirect_to @corredor, notice: 'Corredor was successfully updated.' }
        format.json { render :show, status: :ok, location: @corredor }
      else
        format.html { render :edit }
        format.json { render json: @corredor.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /corredors/1
  # DELETE /corredors/1.json
  def destroy
    @corredor.destroy
    respond_to do |format|
      format.html { redirect_to corredors_url, notice: 'Corredor was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_corredor

      # Se verifica que se esta accediendo correctamente.
      @test = Corredor.where(id: params[:id]).first
      if (@test.nil?)
        render :action=>"index"
      else
        @corredor = Corredor.find(params[:id])
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def corredor_params
      params.require(:corredor).permit(:marca, :modelo, :year, :version, :placa, :zona, :poliza, :nombre, :apellido, :sexo, :estado, :fnacimiento, :informacion, :dia, :mes, :anio, :cedula, :nacion,:tfijo, :cod1, :tcelular, :cod2, :ced, :telefono, :celular,:email, :vehicle_type, :vehicle_use, :cerokm, :sumaAsegurada, :versionList, :user, :actualCoti)
    end

end

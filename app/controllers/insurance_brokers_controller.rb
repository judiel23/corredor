class InsuranceBrokersController < ApplicationController
  before_action :set_insurance_broker, only: [:show, :edit, :update, :destroy]

  # GET /insurance_brokers
  # GET /insurance_brokers.json
  def index
    @insurance_brokers = InsuranceBroker.all
  end

  # GET /insurance_brokers/1
  # GET /insurance_brokers/1.json
  def show
  end

  # GET /insurance_brokers/new
  def new
    @insurance_broker = InsuranceBroker.new
  end

  # GET /insurance_brokers/1/edit
  def edit
  end

  # POST /insurance_brokers
  # POST /insurance_brokers.json
  def create
    @insurance_broker = InsuranceBroker.new(insurance_broker_params)

    respond_to do |format|
      if @insurance_broker.save
        format.html { redirect_to @insurance_broker, notice: 'Insurance broker was successfully created.' }
        format.json { render :show, status: :created, location: @insurance_broker }
      else
        format.html { render :new }
        format.json { render json: @insurance_broker.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /insurance_brokers/1
  # PATCH/PUT /insurance_brokers/1.json
  def update
    respond_to do |format|
      if @insurance_broker.update(insurance_broker_params)
        format.html { redirect_to @insurance_broker, notice: 'Insurance broker was successfully updated.' }
        format.json { render :show, status: :ok, location: @insurance_broker }
      else
        format.html { render :edit }
        format.json { render json: @insurance_broker.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /insurance_brokers/1
  # DELETE /insurance_brokers/1.json
  def destroy
    @insurance_broker.destroy
    respond_to do |format|
      format.html { redirect_to insurance_brokers_url, notice: 'Insurance broker was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_insurance_broker
      @insurance_broker = InsuranceBroker.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def insurance_broker_params
      params.require(:insurance_broker).permit(:users_id, :insurance, :intermediary_code, :plan_code, :plan_review, :discount_rate)
    end
end

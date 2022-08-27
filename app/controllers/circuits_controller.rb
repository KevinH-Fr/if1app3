class CircuitsController < ApplicationController
  before_action :set_circuit, only: %i[ show edit update destroy ]

  # GET /circuits or /circuits.json
  def index
    @circuits = Circuit.all

    @q = Circuit.ransack(params[:q])
    @circuits = @q.result(distinct: true)

    @circuits = @circuits.order(:pays)
  end

  # GET /circuits/1 or /circuits/1.json
  def show

      url = "https://api.openweathermap.org/data/2.5/weather?lat=#{@circuit.latitude}&lon=#{@circuit.longitude}&appid=#{ENV['WEATHER_API_KEY1']}&units=metric&lang=fr"
      uri = URI(url)
      res = Net::HTTP.get_response(uri)
      @data = JSON.parse(res.body)
    
  end

  def new
    @circuit = Circuit.new
  end

  def edit
  end

  def create
    @circuit = Circuit.new(circuit_params)

    respond_to do |format|
      if @circuit.save
        format.html { redirect_to circuit_url(@circuit), notice: "le circuit a bien été créé" }
        format.json { render :show, status: :created, location: @circuit }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @circuit.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @circuit.update(circuit_params)
        format.html { redirect_to circuit_url(@circuit), notice: "le circuit a bien été mis à jour" }
        format.json { render :show, status: :ok, location: @circuit }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @circuit.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @circuit.destroy

    respond_to do |format|
      format.html { redirect_to circuits_url, notice: "le circuit a bien été supprimé" }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_circuit
      @circuit = Circuit.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def circuit_params
      params.require(:circuit).permit(:nom, :pays, :drapeau, :carte, :adresse, :latitude, :longitude)
    end
end

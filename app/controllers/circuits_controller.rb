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

    url = "https://api.openweathermap.org/data/2.5/weather?lat=46.59241268250619&lon=2.4843752747424004&appid=#{ENV['WEATHER_API_KEY1']}&units=metric"
    uri = URI(url)
    res = Net::HTTP.get_response(uri)
    @data = JSON.parse(res.body)
  end

  # GET /circuits/new
  def new
    @circuit = Circuit.new
  end

  # GET /circuits/1/edit
  def edit
  end

  # POST /circuits or /circuits.json
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

  # PATCH/PUT /circuits/1 or /circuits/1.json
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

  # DELETE /circuits/1 or /circuits/1.json
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

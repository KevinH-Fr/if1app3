class SaisonsController < ApplicationController
  before_action :set_saison, only: %i[ show edit update destroy ]

  # GET /saisons or /saisons.json
  def index
    @saisons = Saison.all
  end

  # GET /saisons/1 or /saisons/1.json
  def show
  end

  # GET /saisons/new
  def new
    @saison = Saison.new
  end

  # GET /saisons/1/edit
  def edit
  end

  # POST /saisons or /saisons.json
  def create
    @saison = Saison.new(saison_params)

    respond_to do |format|
      if @saison.save
        format.html { redirect_to saison_url(@saison), notice: "Saison was successfully created." }
        format.json { render :show, status: :created, location: @saison }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @saison.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /saisons/1 or /saisons/1.json
  def update
    respond_to do |format|
      if @saison.update(saison_params)
        format.html { redirect_to saison_url(@saison), notice: "Saison was successfully updated." }
        format.json { render :show, status: :ok, location: @saison }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @saison.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /saisons/1 or /saisons/1.json
  def destroy
    @saison.destroy

    respond_to do |format|
      format.html { redirect_to saisons_url, notice: "Saison was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_saison
      @saison = Saison.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def saison_params
      params.require(:saison).permit(:nom, :numeroSaison, :periode)
    end
end

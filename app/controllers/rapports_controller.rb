class RapportsController < ApplicationController
  before_action :set_rapport, only: %i[ show edit update destroy ]

  # GET /rapports or /rapports.json
  def index
    @rapports = Rapport.all
  end

  # GET /rapports/1 or /rapports/1.json
  def show
  end

  # GET /rapports/new
  def new
    @rapport = Rapport.new
    @pilote = Pilote.all
  end

  # GET /rapports/1/edit
  def edit
  end

  # POST /rapports or /rapports.json
  def create
    @rapport = Rapport.new(rapport_params)

    respond_to do |format|
      if @rapport.save
        format.html { redirect_to rapport_url(@rapport), notice: "Rapport was successfully created." }
        format.json { render :show, status: :created, location: @rapport }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @rapport.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /rapports/1 or /rapports/1.json
  def update
    respond_to do |format|
      if @rapport.update(rapport_params)
        format.html { redirect_to rapport_url(@rapport), notice: "Rapport was successfully updated." }
        format.json { render :show, status: :ok, location: @rapport }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @rapport.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /rapports/1 or /rapports/1.json
  def destroy
    @rapport.destroy

    respond_to do |format|
      format.html { redirect_to rapports_url, notice: "Rapport was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_rapport
      @rapport = Rapport.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def rapport_params
      params.require(:rapport).permit(:event_id, :pilote_id, :penalitelicence, :penalitetemps, :commentaire)
    end
end

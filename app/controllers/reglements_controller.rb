class ReglementsController < ApplicationController
  before_action :set_reglement, only: %i[ show edit update destroy ]

  def index
    @reglements = Reglement.all.order(:numero)
  end

  def show
  end

  def new
    @reglement = Reglement.new
  end

  # GET /reglements/1/edit
  def edit
  end

  # POST /reglements or /reglements.json
  def create
    @reglement = Reglement.new(reglement_params)

    respond_to do |format|
      if @reglement.save
        format.html { redirect_to reglement_url(@reglement), notice: "Reglement was successfully created." }
        format.json { render :show, status: :created, location: @reglement }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @reglement.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /reglements/1 or /reglements/1.json
  def update
    respond_to do |format|
      if @reglement.update(reglement_params)
        format.html { redirect_to reglement_url(@reglement), notice: "Reglement was successfully updated." }
        format.json { render :show, status: :ok, location: @reglement }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @reglement.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /reglements/1 or /reglements/1.json
  def destroy
    @reglement.destroy

    respond_to do |format|
      format.html { redirect_to reglements_url, notice: "Reglement was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_reglement
      @reglement = Reglement.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def reglement_params
      params.require(:reglement).permit(:version, :titre, :numero, :description, :penalite, :commentaire, :penalitetemps)
    end
end

class RapportdoisController < ApplicationController
  before_action :set_rapportdoi, only: %i[ show edit update destroy ]

  def index
    @rapportdois = Rapportdoi.all
  end

  def show
  end

  def documentedition
    @rapportdois = Rapportdoi.all

    @eventId = params[:eventId]
    @eventNum = Event.find(@eventId).numero 
    @saisonId = params[:saisonId]
    @divisionId = params[:divisionId]

    @circuitId = Event.find(@eventId).circuit_id
    @circuitNom = Circuit.find(@circuitId).pays

    @rapportdoiId = params[:rapportdoiId]


    respond_to do |format|
      format.html
      format.png do
      png = Grover.new(url_for(rapportdoiId: @rapportdoiId, saisonId: @saisonId, divisionId: @divisionId, eventId: @eventId, numGp: @numGp)).to_png

      customFilename = "RapportDoi_" "S#{@saisonId}_" "D#{@divisionId}_" "GP#{@eventNum}_" "#{@circuitNom}"".png"

        send_data(png, disposition: 'inline', filename: customFilename, 
                       type: 'application/png', format: 'A4')
      end 
    end
  end

  def new
    @rapportdoi = Rapportdoi.new rapportdoi_params
    @pilotes = Pilote.all
    @reglements = Reglement.all
    @event = Event.all
  end

  def edit
    @pilotes = Pilote.all
    @event = Event.all
    @reglements = Reglement.all
  end

  def create
    @rapportdoi = Rapportdoi.new(rapportdoi_params)

    respond_to do |format|
      if @rapportdoi.save
        format.html { redirect_to rapportdoi_url(@rapportdoi), notice: "Rapportdoi was successfully created." }
        format.json { render :show, status: :created, location: @rapportdoi }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @rapportdoi.errors, status: :unprocessable_entity }
      end
    end
  end

  def update

    @event = Event.all
    @pilotes = Pilote.all
    @reglements = Reglement.all

    respond_to do |format|
      if @rapportdoi.update(rapportdoi_params)
        format.html { redirect_to rapportdoi_url(@rapportdoi), notice: "Rapportdoi was successfully updated." }
        format.json { render :show, status: :ok, location: @rapportdoi }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @rapportdoi.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @rapportdoi.destroy

    respond_to do |format|
      format.html { redirect_to rapportdois_url, notice: "Rapportdoi was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    def set_rapportdoi
      @rapportdoi = Rapportdoi.find(params[:id])
    end

    def rapportdoi_params
      params.fetch(:rapportdoi, {}).permit(:event_id, :demandeur, :pilote_id, :responsable, :decision, :reglement_id, :penalitelicence, :penalitetemps, :commentaire)
    end
end

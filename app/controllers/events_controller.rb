class EventsController < ApplicationController
  before_action :set_event, only: %i[ show edit update destroy ]

  # GET /events or /events.json
  def index
    @events = Event.all

    @saisons = Saison.all
    @divisions = Division.all
    @events = Event.all

    if params[:saisonId]
      @saisonId = params[:saisonId]
    end

    if params[:divisionId]
      @divisionId = params[:divisionId]

      @eventsFiltres = @events.where('saison_id = :saison_id AND division_id = :division_id',
        saison_id: @saisonId, division_id: @divisionId).order(:numero)

    end

  end

  # GET /events/1 or /events/1.json
  def show
    @circuit = Circuit.all
  end

  # GET /events/new
  def new
    @circuit = Circuit.all
    @saison = Saison.all
    @division = Division.all
    @event = Event.new
  end

  # GET /events/1/edit
  def edit
    @circuit = Circuit.all
    @saison = Saison.all
    @division = Division.all
  end

  # POST /events or /events.json
  def create
    @event = Event.new(event_params)

    respond_to do |format|
      if @event.save
        format.html { redirect_to event_url(@event), notice: "l'event a bien été créé" }
        format.json { render :show, status: :created, location: @event }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /events/1 or /events/1.json
  def update
    respond_to do |format|
      if @event.update(event_params)
        format.html { redirect_to event_url(@event), notice: "l'event a bien été mis à jour" }
        format.json { render :show, status: :ok, location: @event }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /events/1 or /events/1.json
  def destroy
    @event.destroy

    respond_to do |format|
      format.html { redirect_to events_url, notice: "l'event a bien été supprimé" }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_event
      @event = Event.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def event_params
      params.require(:event).permit(:date, :horaire, :numero, :circuit_id, :saison_id, :division_id)
    end
end

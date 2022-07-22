class LicencesController < ApplicationController
  before_action :set_licence, only:[:show, :edit, :update, :destroy]

  def index
    @licences = Licence.all

    @saisons = Saison.all
    @divisions = Division.all
    @events = Event.all

    if params[:saisonId]
      @saisonId = params[:saisonId]
    end

    if params[:divisionId]
      @divisionId = params[:divisionId]

      @eventsFiltres = @events.where('saison_id = :saison_id AND division_id = :division_id',
        saison_id: @saisonId, division_id: @divisionId)
    end

    if params[:eventId]
      @eventId = params[:eventId]
      @eventNum = Event.find(@eventId).numero 

      @pilotes = Pilote.all
      @pilotesActifDiv = Pilote.all.where(statut: "actif", division_id: @divisionId) 

      @licencesValDepart = 12

      @licencesEvent = Licence.all.where(event_id: @eventId)

      @licencesFiltres = Licence.joins(:event).where(
        'numero <= :numero AND 
         saison_id = :saison_id AND 
         division_id = :division_id',  
         numero: params[:numGp],
         saison_id: params[:saisonId],
         division_id: params[:divisionId]).group(:pilote_id)
          .select('pilote_id, event_id, penalite, recupere, SUM(penalite) AS total_penalite, SUM(recupere) AS total_recupere')
         
    else
      
      @pilotesActifDiv = Pilote.all
    end

    respond_to do |format|
      format.html
      format.pdf do
       render pdf: "licences", template: "licences/liste", formats: [:html], layout: "pdf"
      end
    end

  end

  def show
  end

  def new
    @licence = Licence.new
    @pilote = Pilote.all
    @event = Event.all
  end

  def edit
    @pilote = Pilote.all
    @event = Event.all
  end

  def create
    @licence = Licence.new(licence_params)

    respond_to do |format|
      if @licence.save
        format.html { redirect_to licence_url(@licence), notice: "Licence was successfully created." }
        format.json { render :show, status: :created, location: @licence }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @licence.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @licence.update(licence_params)
        format.html { redirect_to licence_url(@licence), notice: "Licence was successfully updated." }
        format.json { render :show, status: :ok, location: @licence }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @licence.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @licence.destroy

    respond_to do |format|
      format.html { redirect_to licences_url, notice: "Licence was successfully destroyed." }
      format.json { head :no_content }
    end
  end

def toggle_creerlicences
  @eventId = params[:id]
  @divisionLiee = Event.find(@eventId).division_id
  @saisonLiee = Event.find(@eventId).saison_id

  @pilotesActifDiv = Pilote.all.where(statut: "actif", division_id: @divisionLiee) 
    @pilotesActifDiv.all.each do |pilote|
      licence = Licence.create(pilote_id: pilote.id, event_id: @eventId)
    end
  
  redirect_to licences_url(saisonId: @saisonLiee, eventId: @eventId, divisionId: @divisionLiee), 
                notice: "la licence2 a bien été créée"
end

def toggle_supprimerlicences
  @eventId = params[:id]
  @divisionLiee = Event.find(@eventId).division_id
  @saisonLiee = Event.find(@eventId).saison_id

  Licence.where(event_id: @eventId).destroy_all

  redirect_to licences_url(saisonId: @saisonLiee, eventId: @eventId, divisionId: @divisionLiee),
               notice: "les licences de l'event courant ont bien été supprimées"
end

def toggle_calculrecuplicences

  @eventId = params[:id]
  @licencesValDepart = 12
  @divisionLiee = Event.find(@eventId).division_id
  @saisonLiee = Event.find(@eventId).saison_id
  @licencesEvent = Licence.all.where(event_id: @eventId)

  numEvent = Event.find(@eventId).numero

  if numEvent >= 4

    @licencesEvent.all.each do |lic|

      licenceId = lic.id
      piloteId = lic.pilote_id
      eventId = lic.event_id
      divisionId = Event.find(eventId).division_id 
      saisonId = Event.find(eventId).saison_id 
      numEvent = Event.find(eventId).numero

      perdus_0 = lic.penalite
      recuperes_0 = lic.recupere

      numEvent_1 = numEvent - 1
      eventId_1 = Event.find_by(numero: numEvent_1, saison_id: saisonId, division_id: divisionId).id
      licenceIdPilote_1 = Licence.find_by(event_id: eventId_1, pilote_id: piloteId).id rescue nil

      if licenceIdPilote_1.present?
         perdus_1 = Licence.find(licenceIdPilote_1).penalite
         recuperes_1 = Licence.find(licenceIdPilote_1).recupere
      end

      numEvent_2 = numEvent - 2
      eventId_2 = Event.find_by(numero: numEvent_2, saison_id: saisonId, division_id: divisionId).id  
      licenceIdPilote_2 = Licence.find_by(event_id: eventId_2, pilote_id: piloteId).id rescue nil

      if licenceIdPilote_2.present?
        perdus_2 = Licence.find(licenceIdPilote_2).penalite
        recuperes_2 = Licence.find(licenceIdPilote_2).recupere
      end
       
      pena_n2_n0 = perdus_0.to_i + perdus_1.to_i + perdus_2.to_i
      recup_n2_n0 = recuperes_0.to_i + recuperes_1.to_i + recuperes_2.to_i
     

      totalPenalite = Licence.joins(:event).where(
            'numero <= :numero AND saison_id = :saison_id AND division_id = :division_id AND pilote_id = :pilote_id', 
            numero: numEvent, saison_id: saisonId, division_id: divisionId, pilote_id: piloteId).sum(:penalite)
      
      totalRecupere = Licence.joins(:event).where(
              'numero <= :numero AND saison_id = :saison_id AND division_id = :division_id AND pilote_id = :pilote_id', 
              numero: numEvent, saison_id: saisonId, division_id: divisionId, pilote_id: piloteId).sum(:recupere)

      soldeLicence = @licencesValDepart - totalPenalite.to_i + totalRecupere.to_i

      #recupCourant = pena_n3_n0
    
        if pena_n2_n0 == 0 
          if recup_n2_n0 == 0
            if soldeLicence == 12
            else 
              if soldeLicence == 11
                recupCourant = 1
              else
                recupCourant = 2
              end
               # update que si pas de perte ni de gains sur n-2 a n-0
              licence = Licence.where(event_id: @eventId, pilote_id: piloteId)
              licence.update(recupere: recupCourant)

            end
           
          end
        else
          
        end
       
    end

    redirect_to licences_url(numGp: numEvent, saisonId: @saisonLiee, eventId: @eventId, divisionId: @divisionLiee), 
                  notice: "les points ont bien été calculés"
  else
    redirect_to licences_url(saisonId: @saisonLiee, eventId: @eventId, divisionId: @divisionLiee), 
                  notice: "les points ne peuvent pas être récupérés avant l'event 4"
  end

end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_licence
      @licence = Licence.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def licence_params
      params.require(:licence).permit(:penalite, :recupere, :pilote_id, :event_id)
    end

end

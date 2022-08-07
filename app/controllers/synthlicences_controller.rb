class SynthlicencesController < ApplicationController

  def index
    @divisions = Division.all
    @events = Event.all
    @saisons = Saison.all
    
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
      @divisionId = Event.find(@eventId).division_id 

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
        division_id: params[:divisionId]).group(:event_id, :penalite, :recupere, :pilote_id)
        .select('pilote_id, event_id, penalite, recupere, SUM(penalite) AS total_penalite, SUM(recupere) AS total_recupere')
    else
      @pilotesActifDiv = Pilote.all
    end
  end

  def documentedition
    @eventId = params[:eventId]
    @eventNum =  params[:numGp]
    @saisonId = params[:saisonId]
    @divisionId = params[:divisionId]
  
    @circuitId = Event.find(@eventId).circuit_id
    @circuitNom = Circuit.find(@circuitId).pays

    @licencesValDepart = 12
  
    @licencesFiltres = Licence.joins(:event).where(
      'numero <= :numero AND 
      saison_id = :saison_id AND 
      division_id = :division_id',  
      numero: params[:numGp],
      saison_id: params[:saisonId],
      division_id: params[:divisionId]).group(:event_id, :penalite, :recupere, :pilote_id)
      .select('pilote_id, event_id, penalite, recupere, SUM(penalite) AS total_penalite, SUM(recupere) AS total_recupere')
  
    respond_to do |format|
      format.html
      format.png do
        png = Grover.new(url_for(saisonId: @saisonId, divisionId: @divisionId, eventId: @eventId, numGp: @eventNum)).to_png
        customFilename = "Licences" "S#{@saisonId}_" "D#{@divisionId}_" "GP#{@eventId}_" "#{@circuitNom}"".png"
  
        send_data(png, disposition: 'inline', filename: customFilename, type: 'application/png', format: 'A4')
      end 
    end
  end

end

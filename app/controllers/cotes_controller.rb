class CotesController < ApplicationController
  before_action :set_cote, only: %i[ show edit update destroy ]
  
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

      #  eventN_1 = Event.find_by(saison_id: @saisonId, division_id: @divisionId, numero: @eventNum - 1).id
       # @calculs_cotes = Resultat.saison_courant(@saisonId).division_courant(@divisionId).numero_until_courant(@eventNum)
        #.group_sum_order
      #  @cotes = Classement.event_courant(@eventId).order(:score).reverse

      @cotes = Cote.where(event: @eventId).order(:position)
        # ajouter une methode vers model qui modifie la valeur de base cote en une autre valeur pour avoir cote victoire

      else
      end
  
      respond_to do |format|
        format.html
        format.pdf do
         render pdf: "CotesParis", template: "classements/liste", formats: [:html], layout: "pdf"
        end
      end
  
    end

    def toggle_creercotes
      @eventId = params[:id]
      @divisionId = Event.find(@eventId).division_id
      @saisonLiee = Event.find(@eventId).saison_id
      @numGp = Event.find(@eventId).numero 
    
      @pilotes = Pilote.statut_actif.division_courant(@divisionId).all
        @pilotes.all.each do |pilote|
          cote = Cote.create(pilote_id: pilote.id, event_id: @eventId)
        end
      
      redirect_to cotes_url(saisonId: @saisonLiee, eventId: @eventId, divisionId: @divisionId, numGp: @numGp), 
                    notice: "les cotes ont bien été créés"
    end

    def toggle_updatecotes
      # obtenir position ranking et calculer cotes
      @eventId = params[:id]
      @divisionId = Event.find(@eventId).division_id
      @saisonLiee = Event.find(@eventId).saison_id
      @numGp = Event.find(@eventId).numero 

      @cotesEvent = Cote.all.where(event_id: @eventId)
      @cotesEvent.each do |cote| 
        if @numGp == 1 # gestion exception pour premier gp
          cote.update(position: 1 )
          cote.update(coteVictoire: 4 )
          cote.update(cotePodium: 3 )
          cote.update(coteTop10: 2 )
        else
          @piloteId = cote.pilote_id
          eventN_1 = Event.find_by(saison_id: @saisonLiee, division_id: @divisionId, numero: @numGp - 1).id
          if Classement.where(event_id: eventN_1).first.present? # si classement existe
            @texteNotif = "les cotes ont bien été mises à jour"
            max_points = Classement.where(event_id: eventN_1).max_points.score.to_i
            if Classement.find_by(pilote_id: @piloteId, event_id: eventN_1).nil? # gestion exception nouveau pilote
              valScore = 0
              valPosition = Pilote.statut_actif.division_courant(@divisionId).count 
            else
              valScore = Classement.find_by(pilote_id: @piloteId, event_id: eventN_1).score
              valPosition = Classement.find_by(pilote_id: @piloteId, event_id: eventN_1).position
            end
              valCoteBase = 1 + (((max_points.to_f - valScore)/100) * valPosition )
              cote.update(position: valPosition )
              cote.update(coteVictoire: valCoteBase + ((0.9 * valPosition) /1 )) 
              cote.update(cotePodium:  valCoteBase + ((0.5 * valPosition) /1.5))
              cote.update(coteTop10:   valCoteBase + ((0.3 * valPosition) /2))
              cote.update(cotePole: valCoteBase + ((0.6 * valPosition) /1 )) 
          else
            @texteNotif = "le classement du GP précédent doit d'abord être créé"
          end
           
        end 
      end
        redirect_to cotes_url(saisonId: @saisonLiee, eventId: @eventId, divisionId: @divisionId, numGp: @numGp), 
        notice: @texteNotif
    end
    
    def toggle_supprimercotes
      @eventId = params[:id]
      @divisionId = Event.find(@eventId).division_id
      @saisonId = Event.find(@eventId).saison_id
    
      Cote.where(event_id: @eventId).destroy_all
    
      redirect_to cotes_url(saisonId: @saisonId, eventId: @eventId, divisionId: @divisionId),
                   notice: "les cotes de l'event courant ont bien été supprimées"
    end

    def documentedition
      @eventId = params[:eventId]
      @eventNum =  params[:numero]
      @saisonId = params[:saisonId]
      @divisionId = params[:divisionId]
  
      @circuitId = Event.find(@eventId).circuit_id
      @circuitNom = Circuit.find(@circuitId).pays

      @cotes = Cote.where(event: @eventId).order(:position)
  
      respond_to do |format|
        format.html
        format.png do
        #  png = Grover.new(url_for(only_path: false)).to_png
        png = Grover.new(url_for(saisonId: @saisonId, divisionId: @divisionId, eventId: @eventId, numGp: @numGp)).to_png
  
        customFilename = "Cotes_" "S#{@saisonId}_" "D#{@divisionId}_" "GP#{@eventNum}_" "#{@circuitNom}"".png"
  
          send_data(png, disposition: 'inline', filename: customFilename, 
                         type: 'application/png', format: 'A4')
        end 
      end
    end
  
    private
  
      def set_cote
        @cote = Cote.find(params[:id])
      end
  
      def cote_params
        params.fetch(:cote, {})
      end
  
  end
  
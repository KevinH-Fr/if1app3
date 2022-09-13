class ParieursController < ApplicationController
    
    #  before_action :set_classement, only: %i[ show edit update destroy ]
  
      def index
  
          @divisions = Division.all
          @events = Event.all
          @saisons = Saison.all
      
          @valDepart = 1000

          @pilotes = Pilote.all
  
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
          @saisonId = Event.find(@eventId).saison_id
  


         @parisEvent = Pari.saison_courant(@saisonId).division_courant(@divisionId).numero_until_courant(@eventNum)
                        .group_by_parieur.select('parieur_id, SUM(solde) AS total')

      respond_to do |format|
        format.html
        format.pdf do
  
         render pdf: "parieurs", template: "parieurs/liste", formats: [:html], layout: "pdf"
        end
      end
  
        else
          
        
        end
    
        respond_to do |format|
          format.html
          format.pdf do
    
          # render pdf: "classementPilotes", template: "classements/liste", formats: [:html], layout: "pdf"
          end
        end
        
    end
    
    def show
    end
    
    def documentedition
      @eventId = params[:eventId]
      @eventNum = Event.find(@eventId).numero 
      @saisonId = params[:saisonId]
      @divisionId = params[:divisionId]
  
      @circuitId = Event.find(@eventId).circuit_id
      @circuitNom = Circuit.find(@circuitId).pays


      @parisEvent = Pari.saison_courant(@saisonId).division_courant(@divisionId).numero_until_courant(@eventNum).
      group_by_parieur.select('parieur_id, SUM(solde) AS total')
      
      @parisEvent = @parisEvent.order(:total).reverse

     #@parisEvent = Pari.all.group_by_parieur.select('parieur_id, SUM(solde) AS total')

        @pilotes = Pilote.all

      respond_to do |format|
        format.html
        format.png do
        #  png = Grover.new(url_for(only_path: false)).to_png
        png = Grover.new(url_for(saisonId: @saisonId, divisionId: @divisionId, eventId: @eventId, numGp: @numGp)).to_png
  
        customFilename = "Parieurs_" "S#{@saisonId}_" "D#{@divisionId}_" "GP#{@eventNum}_" "#{@circuitNom}"".png"
  
          send_data(png, disposition: 'inline', filename: customFilename, 
                         type: 'application/png', format: 'A4')
        end 
      end
    end
    

    def toggle_creerparieurs
      @eventId = params[:id]
      @divisionId = Event.find(@eventId).division_id
      @saisonLiee = Event.find(@eventId).saison_id
      @numGp = Event.find(@eventId).numero 
    
      @pilotes = Pilote.statut_actif.division_non_courant(@divisionId).all
        @pilotes.all.each do |pilote|
          parieur = Parieur.create(pilote_id: pilote.id, event_id: @eventId)
        end
      
      redirect_to parieurs_url(saisonId: @saisonLiee, eventId: @eventId, divisionId: @divisionId, numGp: @numGp), 
                    notice: "les classements parieurs ont bien été créés"
    end


    def toggle_supprimerparieurs
      @eventId = params[:id]
      @divisionId = Event.find(@eventId).division_id
      @saisonId = Event.find(@eventId).saison_id
    
      Parieur.where(event_id: @eventId).destroy_all
    
      redirect_to parieurs_url(saisonId: @saisonId, eventId: @eventId, divisionId: @divisionId),
                   notice: "les classements des parieurs de l'event courant ont bien été supprimés"
    end


    def toggle_updateparieurs
      @eventId = params[:id]
      @divisionId = Event.find(@eventId).division_id
      @saisonId = Event.find(@eventId).saison_id
      @numGp = Event.find(@eventId).numero 
    
      @parieursEvent = Parieur.all.where(event_id: @eventId)
      
        @parieursEvent.each do |parieur|
          @piloteId = parieur.pilote_id
    
            if Pilote.find(parieur.pilote_id).rivaliteprec == true 
               montantBase = 2000 
            else
               montantBase = 1000 
            end

          # obtenir le score total du pilote, ajouter les filtres les uns apres les autres
          valScore = Pari.pilote_courant(@piloteId).saison_courant(@saisonId).numero_until_courant(@numGp).sum(:solde)
    
          parieur.update(cumul: valScore + montantBase )
    
          
        end
    
      redirect_to parieurs_url(saisonId: @saisonId, eventId: @eventId, divisionId: @divisionId, numGp: @numGp), 
                    notice: "les classements des parieurs ont bien été mis à jour"
    end

  end
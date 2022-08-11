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
  
         # modifier formuler pour que ca fonctionne avec pg
         
       #  @parisEvent = Pari.saison_courant(@saisonId).division_courant(@divisionId).numero_until_courant(@eventNum).group_sum_order
      
        @parisEvent = Pari.saison_courant(@saisonId).division_courant(@divisionId).numero_until_courant(@eventNum).group_by_parieur.select('parieur_id, SUM(solde) AS total')
         @parisEvent = @parisEvent.order(:total).reverse


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
    
  end
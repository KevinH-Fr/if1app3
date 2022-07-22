class ParieursController < ApplicationController
    
    #  before_action :set_classement, only: %i[ show edit update destroy ]
  
      def index
  
          @divisions = Division.all
          @events = Event.all
          @saisons = Saison.all
      
          @valDepart = 1000
  
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
        @parisEvent = Pari.all
           
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
    
    
    end
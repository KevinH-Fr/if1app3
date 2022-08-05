class ClassecuriesController < ApplicationController
  before_action :set_classecury, only: %i[ show edit update destroy ]

  def index
    @classecuries = Classecurie.all
    @divisions = Division.all
    @events = Event.all
    @saisons = Saison.all

    @pilotes = Pilote.all
    @equipes = Equipe.all
    @resultats = Resultat.all

    @resultatsFiltres = Resultat.all

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

        @resultatsFiltres = Resultat.joins(:event).where(
              'numero <= :numero AND 
               saison_id = :saison_id AND 
               division_id = :division_id',  
               numero: params[:numGp],
               saison_id: params[:saisonId],
               division_id: params[:divisionId])
    
         @resultatsFiltres = @resultatsFiltres.select(:ecurie, "sum(score) as sum_amount").group(:ecurie).order(
                "sum(score) desc").sum(:score)


        @divisionId = Event.find(@eventId).division_id 

        @pilotes = Pilote.all

      else
        @resultats = Resultat.all
        @resultatsFiltres = Resultat.all
       
      end

      respond_to do |format|
        format.html
        format.pdf do
  
         render pdf: "classementEcuries", template: "classecuries/liste", formats: [:html], layout: "pdf"
        end
      end
  end

  
def documentedition
  @eventId = params[:eventId]
  @eventNum = Event.find(@eventId).numero 
  @saisonId = params[:saisonId]
  @divisionId = params[:divisionId]

  @circuitId = Event.find(@eventId).circuit_id
  @circuitNom = Circuit.find(@circuitId).pays


#  @resultats = Resultat.division_courant(@divisionId).saison_courant(@saisonId).
 # numero_until_courant(@eventNum).group_by_ecurie.select(
  #  'ecurie, SUM(score) AS total')


  @resultats = Resultat.division_courant(@divisionId).saison_courant(@saisonId).
  numero_until_courant(@eventNum).
  group_by_ecurie.select('ecurie, SUM(score) AS total')

    @resultats = @resultats.order(:total).reverse

  respond_to do |format|
    format.html
    format.png do
    #  png = Grover.new(url_for(only_path: false)).to_png
    png = Grover.new(url_for(saisonId: @saisonId, divisionId: @divisionId, eventId: @eventId, numGp: @numGp)).to_png

    customFilename = "ClassEcuries_" "S#{@saisonId}_" "D#{@divisionId}_" "GP#{@eventId}_" "#{@circuitNom}_" " .png"

      send_data(png, disposition: 'inline', 
                     filename: customFilename, 
                     type: 'application/png',
                    format: 'A4')
    end 
  end
end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_classecury
      @classecury = Classecurie.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def classecury_params
      params.fetch(:classecury, {})
    end


end

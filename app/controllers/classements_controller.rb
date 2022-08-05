class ClassementsController < ApplicationController
  before_action :set_classement, only: %i[ show edit update destroy ]

  def index
    @classements = Classement.all
    @divisions = Division.all
    @events = Event.all
    @saisons = Saison.all
    @pilotes = Pilote.all
    @resultats = Resultat.all
    @resultatsFiltres = Resultat.all

    @resultat = Resultat.all

    @q = Classement.ransack(params[:q])

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
    
     @classements = Classement.event_courant(@eventId)

      @pilotesActifDiv = Pilote.division_courant(@divisionId).statut_actif
      @pilotesActifDiv = @pilotesActifDiv

     @classementScores = Resultat.division_courant(@divisionId).saison_courant(@saisonId).
                        numero_until_courant(@eventNum).group_by_pilote
    
     @classementsNbP1 = Resultat.division_courant(@divisionId).saison_courant(@saisonId).
                        numero_until_courant(@eventNum).sum_by_pilote

    @resultatsFiltres = Resultat.group_by_pilote.select(
        'pilote_id, SUM(score) AS total, COUNT(course) AS nbCourses' )

    else
      
      @resultats = Resultat.all
      @resultatsFiltres = Resultat.all
      @pilotesActifDiv = Pilote.all
    end

    respond_to do |format|
      format.html
      format.pdf do

       render pdf: "classementPilotes", template: "classements/liste", formats: [:html], layout: "pdf"
      end
    end
    
end

def show
end

def destroy

  @classement.destroy

  respond_to do |format|
    format.html { redirect_to classements_url, notice: "classement was successfully destroyed." }
    format.json { head :no_content }
  end
end

def documentedition
  @eventId = params[:eventId]
  @eventNum =  params[:numero]
  @saisonId = params[:saisonId]
  @divisionId = params[:divisionId]

  @circuitId = Event.find(@eventId).circuit_id
  @circuitNom = Circuit.find(@circuitId).pays

  @classements = Classement.event_courant(@eventId)

  respond_to do |format|
    format.html
    format.png do
    #  png = Grover.new(url_for(only_path: false)).to_png
    png = Grover.new(url_for(saisonId: @saisonId, divisionId: @divisionId, eventId: @eventId, numGp: @numGp)).to_png

    customFilename = "ClassPilotes_" "S#{@saisonId}_" "D#{@divisionId}_" "GP#{@eventId}_" "#{@circuitNom}_" " .png"

      send_data(png, disposition: 'inline', 
                     filename: customFilename, 
                     type: 'application/png',
                    format: 'A4')
    end 
  end
end


def toggle_creerclassements
  @eventId = params[:id]
  @divisionId = Event.find(@eventId).division_id
  @saisonLiee = Event.find(@eventId).saison_id
  @numGp = Event.find(@eventId).numero 

  @pilotes = Pilote.statut_actif.division_courant(@divisionId).all
    @pilotes.all.each do |pilote|
      classement = Classement.create(pilote_id: pilote.id, event_id: @eventId)
    end
  
  redirect_to classements_url(saisonId: @saisonLiee, eventId: @eventId, divisionId: @divisionId, numGp: @numGp), 
                notice: "les classements ont bien été créés"
end

def toggle_supprimerclassements
  @eventId = params[:id]
  @divisionId = Event.find(@eventId).division_id
  @saisonId = Event.find(@eventId).saison_id

  Classement.where(event_id: @eventId).destroy_all

  redirect_to classements_url(saisonId: @saisonId, eventId: @eventId, divisionId: @divisionId),
               notice: "les classements de l'event courant ont bien été supprimés"
end

def toggle_updateclassements
  @eventId = params[:id]
  @divisionId = Event.find(@eventId).division_id
  @saisonId = Event.find(@eventId).saison_id
  @numGp = Event.find(@eventId).numero 


  @classementsEvent = Classement.all.where(event_id: @eventId).order_by_score
  
    @classementsEvent.each do |classement|
      @piloteId = classement.pilote_id

      # obtenir le score total du pilote, ajouter les filtres les uns apres les autres
      valScore = Resultat.pilote_courant(@piloteId).division_courant(@divisionId).saison_courant(@saisonId).numero_until_courant(@numGp).sum(:score)
    #  valCoteBase = max_points - valScore

      classement.update(score: valScore )


      nbP1 = Resultat.pilote_courant(classement.pilote_id).division_courant(@divisionId).saison_courant(@saisonId).numero_until_courant(@numGp).where(course: 1).count
      nbP2 = Resultat.pilote_courant(classement.pilote_id).division_courant(@divisionId).saison_courant(@saisonId).numero_until_courant(@numGp).where(course: 2).count
      nbP3 = Resultat.pilote_courant(classement.pilote_id).division_courant(@divisionId).saison_courant(@saisonId).numero_until_courant(@numGp).where(course: 3).count
      nbP4 = Resultat.pilote_courant(classement.pilote_id).division_courant(@divisionId).saison_courant(@saisonId).numero_until_courant(@numGp).where(course: 4).count
      nbP5 = Resultat.pilote_courant(classement.pilote_id).division_courant(@divisionId).saison_courant(@saisonId).numero_until_courant(@numGp).where(course: 5).count
      nbP6 = Resultat.pilote_courant(classement.pilote_id).division_courant(@divisionId).saison_courant(@saisonId).numero_until_courant(@numGp).where(course: 6).count
      nbP7 = Resultat.pilote_courant(classement.pilote_id).division_courant(@divisionId).saison_courant(@saisonId).numero_until_courant(@numGp).where(course: 7).count
      nbP8 = Resultat.pilote_courant(classement.pilote_id).division_courant(@divisionId).saison_courant(@saisonId).numero_until_courant(@numGp).where(course: 8).count
      nbP9 = Resultat.pilote_courant(classement.pilote_id).division_courant(@divisionId).saison_courant(@saisonId).numero_until_courant(@numGp).where(course: 9).count
      nbP10 = Resultat.pilote_courant(classement.pilote_id).division_courant(@divisionId).saison_courant(@saisonId).numero_until_courant(@numGp).where(course: 10).count
      #nbP11 = Resultat.pilote_courant(classement.pilote_id).division_courant(@divisionId).saison_courant(@saisonId).numero_until_courant(@numGp).where(course: 11).count
      #nbP12 = Resultat.pilote_courant(classement.pilote_id).division_courant(@divisionId).saison_courant(@saisonId).numero_until_courant(@numGp).where(course: 12).count
      #nbP13 = Resultat.pilote_courant(classement.pilote_id).division_courant(@divisionId).saison_courant(@saisonId).numero_until_courant(@numGp).where(course: 13).count
      #nbP14 = Resultat.pilote_courant(classement.pilote_id).division_courant(@divisionId).saison_courant(@saisonId).numero_until_courant(@numGp).where(course: 14).count
      #nbP15 = Resultat.pilote_courant(classement.pilote_id).division_courant(@divisionId).saison_courant(@saisonId).numero_until_courant(@numGp).where(course: 15).count
      #nbP16 = Resultat.pilote_courant(classement.pilote_id).division_courant(@divisionId).saison_courant(@saisonId).numero_until_courant(@numGp).where(course: 16).count
      #nbP17 = Resultat.pilote_courant(classement.pilote_id).division_courant(@divisionId).saison_courant(@saisonId).numero_until_courant(@numGp).where(course: 17).count
      #nbP18 = Resultat.pilote_courant(classement.pilote_id).division_courant(@divisionId).saison_courant(@saisonId).numero_until_courant(@numGp).where(course: 18).count
      #nbP19 = Resultat.pilote_courant(classement.pilote_id).division_courant(@divisionId).saison_courant(@saisonId).numero_until_courant(@numGp).where(course: 19).count
      #nbP20 = Resultat.pilote_courant(classement.pilote_id).division_courant(@divisionId).saison_courant(@saisonId).numero_until_courant(@numGp).where(course: 20).count
    
      classement.update(nb_p1:  nbP1)
      classement.update(nb_p2:  nbP2)
      classement.update(nb_p3:  nbP3)
      classement.update(nb_p4:  nbP4)
      classement.update(nb_p5:  nbP5)
      classement.update(nb_p6:  nbP6)
      classement.update(nb_p7:  nbP7)
      classement.update(nb_p8:  nbP8)
      classement.update(nb_p9:  nbP9)
      classement.update(nb_p10:  nbP10)
      #classement.update(nb_p11:  nbP11)
      #classement.update(nb_p12:  nbP12)
      #classement.update(nb_p13:  nbP13)
      #classement.update(nb_p14:  nbP14)
      #classement.update(nb_p15:  nbP15)
      #classement.update(nb_p16:  nbP16)
      #classement.update(nb_p17:  nbP17)
      #classement.update(nb_p18:  nbP18)
      #classement.update(nb_p19:  nbP19)
      #classement.update(nb_p20:  nbP20)
      
    end

  redirect_to classements_url(saisonId: @saisonId, eventId: @eventId, divisionId: @divisionId, numGp: @numGp), 
                notice: "les classements ont bien été mis à jour"
end

def toggle_triclassements
  @eventId = params[:id]
  @divisionId = Event.find(@eventId).division_id
  @saisonId = Event.find(@eventId).saison_id
  @numGp = Event.find(@eventId).numero 

  max_points = Classement.saison_courant(@saisonId).division_courant(@divisionId).numero_until_courant(@numGp).max_points.score.to_i

  @classementsEvent = Classement.all.where(event_id: @eventId).order_score_positions

    @classementsEvent.each_with_index do |classement, i|
      i = i + 1
      valPosition = i 
      valScore = classement.score
      valCoteBase = 1 + (((max_points - valScore)/100) * i )

      classement.update(position:  valPosition)
      classement.update(cote_victoire:  valCoteBase + 1.4)
      classement.update(cote_podium:  valCoteBase + 0.9 )
      classement.update(cote_top10:  valCoteBase + 0.3)
    end

  redirect_to classements_url(saisonId: @saisonId, eventId: @eventId, divisionId: @divisionId, numGp: @numGp), 
                notice: "les classements ont bien été triés"
end




def toggle_updateclassementsbis

  @eventId = params[:id]
  @divisionId = Event.find(@eventId).division_id
  @saisonId = Event.find(@eventId).saison_id
  @numGp = Event.find(@eventId).numero 


  @pilotesActifDiv = Pilote.division_courant(@divisionId).statut_actif.order_score

  @pilotesActifDiv.each do | pilote |
   
    valScore = Resultat.pilote_courant(pilote.id).division_courant(@divisionId).saison_courant(@saisonId).numero_until_courant(@numGp).sum(:score)
    nbP1 = Resultat.pilote_courant(pilote.id).division_courant(@divisionId).saison_courant(@saisonId).numero_until_courant(@numGp).where(course: 1).count
    nbP2 = Resultat.pilote_courant(pilote.id).division_courant(@divisionId).saison_courant(@saisonId).numero_until_courant(@numGp).where(course: 2).count
    nbP3 = Resultat.pilote_courant(pilote.id).division_courant(@divisionId).saison_courant(@saisonId).numero_until_courant(@numGp).where(course: 3).count
    nbP4 = Resultat.pilote_courant(pilote.id).division_courant(@divisionId).saison_courant(@saisonId).numero_until_courant(@numGp).where(course: 4).count
    nbP5 = Resultat.pilote_courant(pilote.id).division_courant(@divisionId).saison_courant(@saisonId).numero_until_courant(@numGp).where(course: 5).count

    pilote.update(points:  valScore)
    pilote.update(nb_p1:  nbP1)
    pilote.update(nb_p2:  nbP2)
    pilote.update(nb_p3:  nbP3)
    pilote.update(nb_p4:  nbP4)
    pilote.update(nb_p5:  nbP5)
  end

  redirect_to classements_url(saisonId: @saisonId, eventId: @eventId, divisionId: @divisionId, numGp: @numGp), 
  notice: "l'action a été exécutée"

end

def toggle_trierclassementsbis

  @eventId = params[:id]
  @divisionId = Event.find(@eventId).division_id
  @saisonId = Event.find(@eventId).saison_id
  @numGp = Event.find(@eventId).numero 

  @pilotesActifDiv = Pilote.division_courant(@divisionId).statut_actif.order_score

    @pilotesActifDiv.each_with_index do | pilote, i |
      i = i + 1
      valPosition = i 

      pilote.update(rang_n0:  valPosition)
    end

    redirect_to classements_url(saisonId: @saisonId, eventId: @eventId, divisionId: @divisionId, numGp: @numGp), 
    notice: "l'action a été exécutée"
  
end









  private

    def set_classement
      @classement = Classement.find(params[:id])
    end

    def classement_params
     # params.fetch(:classement, {})
     params.require(:classement).permit(:cote, :pilote_id, :event_id)
    end

end
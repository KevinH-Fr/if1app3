class ParisController < ApplicationController
  before_action :set_pari, only: %i[ show edit update destroy ]

  def index

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

      @paris = Pari.event_courant(@eventId).all

      @coureur = Pilote.statut_actif.division_courant(@divisionId).all
      @parieur = Pilote.statut_actif.division_non_courant(@divisionId).all

    else
      
    end

  end

  def show
    
  end

  def new
    @divisionId = params[:divisionId]
    @eventId = params[:eventId]

    @pari = Pari.new(pari_params)

    @coureur = Pilote.statut_actif.division_courant(@divisionId).all
    @parieur = Pilote.statut_actif.division_non_courant(@divisionId).all

    @event = Event.all

  end

  def edit
    @coureur = Pilote.statut_actif.division_courant(@divisionId).all
    @parieur = Pilote.statut_actif.division_non_courant(@divisionId).all
    
    @event = Event.all
  end

  def create
    @pari = Pari.new(pari_params)
    @coureur = Pilote.statut_actif.division_courant(@divisionId).all
    @parieur = Pilote.statut_actif.division_non_courant(@divisionId).all

    @event = Event.all
    @pilote = Pilote.all

    respond_to do |format|
      if @pari.save
        format.html { redirect_to pari_url(@pari), notice: "Pari was successfully created." }
        format.json { render :show, status: :created, location: @pari }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @pari.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @pari.update(pari_params)
        format.html { redirect_to pari_url(@pari), notice: "Pari was successfully updated." }
        format.json { render :show, status: :ok, location: @pari }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @pari.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @pari.destroy

    respond_to do |format|
      format.html { redirect_to paris_url, notice: "Pari was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def toggle_calculresultats

    @eventId = params[:id]
    @divisionId = Event.find(@eventId).division_id
    @saisonId = Event.find(@eventId).saison_id

    @parisEvent = Pari.event_courant(@eventId)

    @parisEvent.all.each do |pari|

      coureurId = pari.coureur_id
      typePari = pari.typepari
      resultatCoureur = Resultat.where(event_id: @eventId, pilote_id: coureurId).first.course

      if typePari == "victoire" && resultatCoureur == 1
          pari.update(resultat: true)
      else
        if typePari == "podium" && resultatCoureur <= 3
          pari.update(resultat: true)
        else
          if typePari == "top10" && resultatCoureur <= 10
            pari.update(resultat: true)
          else
            pari.update(resultat: false)
          end
        end
      end

      

    end  
    
    redirect_to paris_url(saisonId: @saisonId, eventId: @eventId, divisionId: @divisionId),
               notice: "les résultats des paris de l'event courant ont bien été mis à jour"

  end


  private
    def set_pari
      @pari = Pari.find(params[:id])
    end

    def pari_params
      
      params.fetch(:pari, {}).permit(:montant, :cote, :resultat, :solde, :event_id, :parieur_id, :coureur_id, :typepari)
    end
end

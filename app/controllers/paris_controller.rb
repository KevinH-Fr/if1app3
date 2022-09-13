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

      @paris = Pari.event_courant(@eventId).all.order(:id)

      @coureur = Pilote.statut_actif.division_courant(@divisionId).all
      @parieur = Pilote.statut_actif.division_non_courant(@divisionId).all

      session[:event] = params[:eventId]

      
    respond_to do |format|
      format.html
      format.pdf do

       render pdf: "resultats", template: "paris/liste", formats: [:html], layout: "pdf"
      end
    end


    else
      
    end

  end

  def show
    
  end

  def new
    @pari = Pari.new(pari_params)
    @divisionId = params[:divisionId]
   # @eventId = params[:eventId]

   @event_id_test = session[:event]

    @coureur = Pilote.statut_actif.division_courant(@divisionId).all
    @parieur = Pilote.statut_actif.division_non_courant(@divisionId).all

  #  @event = Event.all

  end

  def edit
    @event = Event.all
    @divisionId = Event.find(session[:event]).division_id # utiliser param event session
    @coureur = Pilote.all
    @parieur = Pilote.statut_actif.division_non_courant(@divisionId).all
    

  end

  def create
    @pari = Pari.new(pari_params)
    @divisionId = params[:divisionId]

    @coureur = Pilote.all

   # @eventId = params[:eventId]
   # session[:event] =  params[:eventId]
   
  #  @event = Event.all
    @pilote = Pilote.all

    respond_to do |format|
      if @pari.save
        format.html { redirect_to pari_url(@pari), notice: "le pari a bien été placé" }
        format.json { render :show, status: :created, location: @pari }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @pari.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @coureur = Pilote.all

    respond_to do |format|
      if @pari.update(pari_params)
        format.html { redirect_to pari_url(@pari), notice: "le pari a bien été mis à jour" }
        format.json { render :show, status: :ok, location: @pari }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @pari.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy

    @pari.destroy
    eventId = session[:event]
    divisionId = Event.find(eventId).division_id
    saisonId = Event.find(eventId).saison_id

    respond_to do |format|
      format.html { redirect_to paris_url(saisonId: saisonId, eventId: eventId, divisionId: divisionId), notice: "le pari a bien été supprimé" }
      format.json { head :no_content }
    end
  end

  def toggle_calculresultats

    @eventId = session[:event]
    @divisionId = Event.find(@eventId).division_id
    @saisonId = Event.find(@eventId).saison_id


    # a verifier avec la var @eventId
  #  @parisEvent = Pari.event_courant(@eventId)

    @pariEvent = Pari.where(event_id: @eventId)


    @pariEvent.each do |pari|
      coureurId = pari.coureur.id
      typePari = pari.paritype
      eventIdPari = pari.event_id
      
      if Resultat.where(event_id: eventIdPari, pilote_id: coureurId).present?
        resultatCoureur = Resultat.where(event_id: eventIdPari, pilote_id: coureurId).first.course
        resultatQualif = Resultat.where(event_id: eventIdPari, pilote_id: coureurId).first.qualification
        statutDnsCoureur = Resultat.where(event_id: eventIdPari, pilote_id: coureurId).first.dns
        pariMontant = pari.montant
        pariCote = pari.cote
    
          if statutDnsCoureur == true #remboursement dns
           # pari = Pari.find_by(id: pari.id)
           # pari.update(resultat: true)
           # pari.update(solde: pariMontant )

            pari = Pari.find(pari.id)
            pari.assign_attributes({resultat: true})
            pari.save(validate: false)
          else
            if typePari == "victoire" && resultatCoureur == 1 
             # pari = Pari.find_by(id: pari.id)
             # pari.update(resultat: true)
             # pari.update(solde: pariMontant * pariCote - pariMontant )
            
             pari = Pari.find(pari.id)
             pari.assign_attributes({resultat: true})
             pari.save(validate: false)

            else 

              if typePari == "podium" && resultatCoureur <= 3
             #   pari = Pari.find_by(id: pari.id)
             #   pari.update(resultat: true)
             #   pari.update(solde: pariMontant * pariCote - pariMontant )

              pari = Pari.find(pari.id)
              pari.assign_attributes({resultat: true})
              pari.save(validate: false)  

            else 

                if typePari == "top10" && resultatCoureur <= 10
               #   pari = Pari.find_by(id: pari.id)
               #   pari.update(resultat: true)
               #   pari.update(solde: pariMontant * pariCote - pariMontant )

                  pari = Pari.find(pari.id)
                  pari.assign_attributes({resultat: true})
                  pari.save(validate: false)

                else 

                  if typePari == "pole" && resultatQualif == 1
                #    pari = Pari.find_by(id: pari.id)
                #    pari.update(resultat: true)
                #    pari.update(solde: pariMontant * pariCote - pariMontant )
              
                pari = Pari.find(pari.id)
                pari.assign_attributes({resultat: true})
                pari.save(validate: false)
              
              end 
                end
              end
            end


          end 
          
          # else
          #   pari.update(resultat: false)
          #   pari.update(solde: - pariMontant )
       
     # else
      #  pariMontant = pari.montant
      #  pari.update(resultat: false)
      #  pari.update(solde: - pariMontant )
      end
        
    end  
    
    redirect_to paris_url(saisonId: @saisonId, eventId: @eventId, divisionId: @divisionId),
               notice: "les résultats des paris de l'event courant ont bien été mis à jour"

  end



  def toggle_recupEvent

    redirect_to new_pari_path(),
    notice: "test recup event courant "
  end

  private
    def set_pari
      @pari = Pari.find(params[:id])
    end

    def pari_params
      
      params.fetch(:pari, {}).permit(:montant, :cote, :resultat, :solde, :event_id, :parieur_id, :coureur_id, :paritype)
      

    end
end
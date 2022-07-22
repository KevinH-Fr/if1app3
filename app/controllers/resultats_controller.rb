class ResultatsController < ApplicationController
  before_action :set_resultat, :formatted_name2, only: %i[ show edit update destroy ]



  # GET /resultats or /resultats.json
  def index
    @classements = Classement.all
    @saisons = Saison.all
    @divisions = Division.all
    @events = Event.all
    @pilotes = Pilote.all
    @resultats = Resultat.all
    @resultatsFiltres = Resultat.all
    
    @resultat = Resultat.all


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
         'event_id = :event_id',
          event_id: @eventId)
        
     @resultatsFiltres = @resultatsFiltres.order(:course)

      @divisionId = Event.find(@eventId).division_id 

      @pilotes = Pilote.all
      @pilotesActifDiv = Pilote.all.where(statut: "actif", division_id: @divisionId) 
      #@resultatsMaxNumGp = @resultats.all.where('event_id: <=' @eventId) 
      
    else
      
      @resultats = Resultat.all
      @resultatsFiltres = Resultat.all
      @pilotesActifDiv = Pilote.all
    end

    @q = Resultat.ransack(params[:q])
    @resultats = @q.result(distinct: true)



    respond_to do |format|
      format.html
      format.pdf do

       render pdf: "resultats", template: "resultats/liste", formats: [:html], layout: "pdf"
      end
    end

  end

  # GET /resultats/1 or /resultats/1.json
  def show
  #  @valPoints = valScore
    @pilote = Pilote.all
  end

  # GET /resultats/new
  def new
    @pilote = Pilote.all
    @event = Event.all
    @resultat = Resultat.new resultat_params

  end

  # GET /resultats/1/edit
  def edit
 #   @valPoints = valScore
    @event = Event.all
    @pilote = Pilote.all
    @equipe = Equipe.all
  end

  # POST /resultats or /resultats.json
  def create
    @pilote = Pilote.all
    @equipe = Equipe.all
    @event = Event.all
    @resultat = Resultat.new(resultat_params)

    respond_to do |format|
      if @resultat.save
        format.html { redirect_to resultat_url(@resultat), notice: "Le résultat a bien été créé." }
        format.json { render :show, status: :created, location: @resultat }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @resultat.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /resultats/1 or /resultats/1.json
  def update

  #  @valPoints = valScore
    @pilote = Pilote.all
    @equipe = Equipe.all
    @event = Event.all

    respond_to do |format|
      if @resultat.update(resultat_params)
        format.html { redirect_to resultat_url(@resultat), notice: "Le résultat a bien été mis à jour." }
        format.json { render :show, status: :ok, location: @resultat }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @resultat.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /resultats/1 or /resultats/1.json
  def destroy
    @resultat.destroy

    respond_to do |format|
      format.html { redirect_to resultats_url, notice: "Le résultat a bien été détruit." }
      format.json { head :no_content }
    end
  end


  # test hotwire maj select option
  def pilotes
    @target = params[:target]
    @pilotes = Pilote.get(params[:pilote])

    respond_to do |format|
      format.turbo_stream
    end
  end


  def valScore
    totalScore = 40
  end 

  private


  def formatted_name2
   # "#{id} | #{event_id} | #{pilote_id}"
end



    # Use callbacks to share common setup or constraints between actions.
    def set_resultat
      @resultat = Resultat.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def resultat_params
    #  params.require(:resultat).permit(:event_id, :pilote_id, :qualification, :course, :dotd, :mt, :score, :ecurie)

      params.fetch(:resultat, {}).permit(:event_id, :pilote_id, :qualification, :course, :dotd, :mt, :score, :ecurie, :positions)
    
    end




    def valPoints
      if @resultat.course == 1 
         pointsCourse = 25
      else 
        if @resultat.course == 2 
          pointsCourse = 18 
        else 
          if @resultat.course == 3 
            pointsCourse = 15 
          else 
            if @resultat.course == 4 
              pointsCourse = 12 
            else 
              if @resultat.course == 5 
                pointsCourse = 10 
              else 
                if @resultat.course == 6 
                  pointsCourse = 8 
                else
                  if @resultat.course == 7 
                    pointsCourse = 6 
                  else
                    if @resultat.course == 8 
                      pointsCourse = 4 
                    else
                      if @resultat.course == 9 
                        pointsCourse = 2 
                      else 
                        if @resultat.course == 10
                          pointsCourse = 1 
                        else
                          pointsCourse = 0
                        end
                      end 
                    end
                  end 
                end
              end 
            end
          end 
        end
      end 

      if @resultat.dotd == true 
         scoreDotd = 1 
      end 
      if @resultat.mt == true 
         scoreMt = 1 
      end 

      calculAuto = pointsCourse  + scoreDotd.to_i + scoreMt.to_i 
      
      
    end
    
end

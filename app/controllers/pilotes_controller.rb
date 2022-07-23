class PilotesController < ApplicationController
 before_action :set_pilote, only: %i[ show edit update destroy ]

  # GET /pilotes or /pilotes.json
  def index

    @equipe = Equipe.all
    
    @countPilotes = Pilote.count
    @pilotes = Pilote.order(:ecurie).page params[:page]
   
    @divisions = Division.all

    @q = Pilote.ransack(params[:q])
  #  @pilotes = @q.result(distinct: true).order(:ecurie)
    @pilotes = @q.result(distinct: true).order(:ecurie).page params[:page]


   
    respond_to do |format|
      format.html
      format.pdf do

        if params[:divId]
          @divId = params[:divId]
          @pilotes = Pilote.all.where(statut: 'actif', division_id: @divId).order(:ecurie)
        else
          @pilotes = Pilote.all.where(statut: 'actif') 
        end
       render pdf: "pilotes", template: "pilotes/liste", formats: [:html], layout: "pdf", disposition: :attachment
      end
    end
    
  end

  # GET /pilotes/1 or /pilotes/1.json
  def show

  #  @pilote = Pilote.find(params[:div])

    @equipe = Equipe.all
    @divisions = Division.all

    if params[:div].present?
      div = Pilote.params[:div]
      @pilotes = Pilote.all.where(division_id: div)

    
    else
      @pilotes = Pilote.all
    end

        respond_to do |format|
          format.html
          format.pdf do

            pdf = ReportPdf.new(@pilotes)
            send_data pdf.render, filename: 'report.pdf', type: 'application/pdf'
           
      end
    end

  end



  # GET /pilotes/new
  def new
    @equipe = Equipe.all
    @pilote = Pilote.new
    @division = Division.all
    @user = User.all
  end

  # GET /pilotes/1/edit
  def edit
    @equipe = Equipe.all
    @division = Division.all
    @user = User.all
  end

  # POST /pilotes or /pilotes.json
  def create
    @equipe = Equipe.all
    @pilote = Pilote.new(pilote_params)

    respond_to do |format|
      if @pilote.save
        format.html { redirect_to pilote_url(@pilote), notice: "Le pilote a bien été créé." }
        format.json { render :show, status: :created, location: @pilote }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @pilote.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /pilotes/1 or /pilotes/1.json
  def update
    respond_to do |format|
      if @pilote.update(pilote_params)
        format.html { redirect_to pilote_url(@pilote), notice: "Le pilote a bien été mis à jour." }
        format.json { render :show, status: :ok, location: @pilote }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @pilote.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /pilotes/1 or /pilotes/1.json
  def destroy
    @pilote.destroy

    respond_to do |format|
      format.html { redirect_to pilotes_url, notice: "Le pilote a bien été supprimé." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_pilote
      @pilote = Pilote.find(params[:id])
    end


   
    # Only allow a list of trusted parameters through.
    def pilote_params
      params.require(:pilote).permit(:nom, :statut, :ecurie, :division_id, :user_id, :div)
    end

  

end

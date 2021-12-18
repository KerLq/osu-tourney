class Backend::TourneysController < Backend::BackendController
  before_action :set_tourney, only: %i[ show edit update destroy ]

  # GET /tourneys or /tourneys.json
  def index
    @tourneys = Tourney.all
    #@user = User.find(params[:user_id])
  end


  # GET /tourneys/1 or /tourneys/1.json
  def show
    @user = User.find(params[:user_id])
    @tourney = @user.tourneys.find(params[:id])
    @matches = @tourney.matches.all
  end
  
  # GET /tourneys/new
  def new
    @user = User.find(params[:user_id])
    @tourney = @user.tourneys.new
  end

  # GET /tourneys/1/edit
  def edit
  end
  

  # PATCH/PUT /tourneys/1 or /tourneys/1.json
  def update
    respond_to do |format|
      if @tourney.update(tourney_params)
        format.html { redirect_to @tourney, notice: "Tourney was successfully updated." }
        format.json { render :show, status: :ok, location: @tourney }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @tourney.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tourneys/1 or /tourneys/1.json
  def destroy
    @user = User.find(params[:user_id])
    @tourney = @user.tourneys.find(params[:id])

    respond_to do |format|
      if @tourney.destroy
        format.html { redirect_to @user, notice: "Tourney was successfully destroyed." }
        format.json { head :no_content }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_tourney
      @tourney = Tourney.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def tourney_params
      params.require(:tourney).permit(:title, :forumpost, :spreadsheet, :forumpost_id)
    end
end

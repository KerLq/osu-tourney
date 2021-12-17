class MatchesController < ApplicationController
  before_action :set_match, only: %i[ show edit update destroy ]
  before_action :check_if_admin?, only: %i[ show index]
  # GET /matches or /matches.json
  def index
    @user = User.find(params[:user_id])
    tourney = @user.tourneys.find(params[:tourney_id])
    @matches = @tourney.matches.all

  end

  # GET /matches/1 or /matches/1.json
  def show
  end

  # GET /matches/new
  def new
    @user = User.find(params[:user_id])
    @tourney = @user.tourneys.find(params[:tourney_id])
    @match = @tourney.matches.new
  end

  # GET /matches/1/edit
  def edit
  end

  # POST /matches or /matches.json
  def create
    url = params[:match][:mp_link]
    if url =~ URI::regexp
      # Correct URL
      response = apiRequest(url)
      @user = User.find(params[:user_id])
      @tourney = @user.tourneys.find(params[:tourney_id])
      @match = @tourney.matches.create(match_params)
      scores = @match.filter_match(@user, response) # GET everything needed
      if scores == "ERROR"
        flash['error'] = "error"
        redirect_to user_path(@user)
      end
      average_score = @match.calculate_average_score(scores)
      
      @match.update_attribute(
        :average_score, average_score
      )
      respond_to do |format| 
        format.js
        format.html { redirect_to @user }    
      end
    else
      flash['error'] = "Invalid URL!"
      redirect_to user_path(@user)
    end

  end

  # PATCH/PUT /matches/1 or /matches/1.json
  def update
    respond_to do |format|
      if @match.update(match_params)
        format.html { redirect_to @match, notice: "Match was successfully updated." }
        format.json { render :show, status: :ok, location: @match }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @match.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /matches/1 or /matches/1.json
  def destroy
    @user = User.find(params[:user_id])
    @tourney = @user.tourneys.find(params[:tourney_id])
    @match = @tourney.matches.find(params[:id])

    @match.destroy
    respond_to do |format|
      format.html { redirect_to user_tourney_matches_path(@user, @tourney), notice: "Match was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_match
      @match = Match.find(params[:id])
    end
    private
    def check_if_admin?  
        redirect_to root_path if !is_admin?
    end
    # Only allow a list of trusted parameters through.
    def match_params
      params.require(:match).permit(:mp_link, :warmup, :matchcost, :average_score)
    end
end

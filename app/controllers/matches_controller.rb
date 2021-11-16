class MatchesController < ApplicationController
  before_action :set_match, only: %i[ show edit update destroy ]

  # GET /matches or /matches.json
  def index
    @matches = Match.all
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
    response = apiRequest(url)
    @user = User.find(params[:user_id])
    @tourney = @user.tourneys.find(params[:tourney_id])
    @match = @tourney.matches.create(match_params)
    @scores = @match.filter_match(@user, response)
    @match.update_attribute(
      :average_score, @scores
    )
    debugger

    redirect_to user_tourney_match_path(@user, @tourney, @match)    

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
    @match.destroy
    respond_to do |format|
      format.html { redirect_to matches_url, notice: "Match was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_match
      @match = Match.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def match_params
      params.require(:match).permit(:mp_link, :warmup, :matchcost, :average_score)
    end
end

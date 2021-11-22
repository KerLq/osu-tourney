class TourneysController < ApplicationController
  before_action :set_tourney, only: %i[ show edit update destroy ]
  before_action :require_permission, only: [:new, :edit, :update, :destroy]
  after_action :save_my_previous_url

  # GET /tourneys or /tourneys.json
  def index
    @tourneys = Tourney.all
  end
  
  def forumpost
    forumpost_id = params[:tourney][:forumpost]
    forumpost_id = forumpost_id[/\d+/] 
    url = URI("https://osu.ppy.sh/api/v2/forums/topics/#{forumpost_id}")
    response = apiRequest(url)
    title = response['topic']['title']
    timestamp = response['topic']['created_at']
    timestamp = timestamp[0..9]
    year = timestamp[0..3]
    month = timestamp[5..6]

    return title, year, month
  end
  
  # GET /tourneys/1 or /tourneys/1.json
  def show
  end
  
  # GET /tourneys/new
  def new
    @user = User.find(params[:user_id])
    @tourney = @user.tourneys.new
  end

  # GET /tourneys/1/edit
  def edit
  end
  
  # POST /tourneys or /tourneys.json
  def create
    @user = User.find(params[:user_id])
    @tourney = @user.tourneys.new(tourney_params)
    #@tourney.update(title: title)
    debugger
    respond_to do |format|
      if @tourney.save
        title = forumpost[0]
        if @tourney.update(title: title)
          format.js
          format.html { redirect_to @user }
        end
      end
    end
      
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

    def require_permission
      if current_user != User.find(params[:user_id])
        flash[:error] = "Permission Denied!"
        redirect_to session[:my_previous_url]
      end
    end

    def save_my_previous_url
      # session[:previous_url] is a Rails built-in variable to save last url.
      session[:my_previous_url] = request.fullpath
    end

    # Only allow a list of trusted parameters through.
    def tourney_params
      params.require(:tourney).permit(:title, :forumpost, :spreadsheet)
    end
end

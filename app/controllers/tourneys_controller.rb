class TourneysController < ApplicationController
  before_action :set_tourney, only: %i[ show edit update destroy ]
  before_action :require_permission, only: [:new, :edit, :update, :destroy]
  after_action :save_my_previous_url

  # GET /tourneys or /tourneys.json
  def index
    @tourneys = Tourney.all
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
    @tourney = @user.tourneys.create(tourney_params)

      if @tourney.save
        flash[:success] = "Tournament was successfully created."
        redirect_to user_tourney_path(@user, @tourney)
      else
        
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
    @tourney.destroy
    respond_to do |format|
      format.html { redirect_to tourneys_url, notice: "Tourney was successfully destroyed." }
      format.json { head :no_content }
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
      params.require(:tourney).permit(:title, :spreadsheet)
    end
end

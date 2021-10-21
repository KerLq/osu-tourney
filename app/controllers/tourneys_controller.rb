class TourneysController < ApplicationController
  before_action :set_tourney, only: %i[ show edit update destroy ]

  # GET /tourneys or /tourneys.json
  def index
    @tourneys = Tourney.all
  end

  # GET /tourneys/1 or /tourneys/1.json
  def show
  end

  # GET /tourneys/new
  def new
    @tourney = Tourney.new
  end

  # GET /tourneys/1/edit
  def edit
  end

  # POST /tourneys or /tourneys.json
  def create
    @tourney = Tourney.new(tourney_params)

    respond_to do |format|
      if @tourney.save
        format.html { redirect_to @tourney, notice: "Tourney was successfully created." }
        format.json { render :show, status: :created, location: @tourney }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @tourney.errors, status: :unprocessable_entity }
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

    # Only allow a list of trusted parameters through.
    def tourney_params
      params.require(:tourney).permit(:title, :spreadsheet)
    end
end

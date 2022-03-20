class Frontend::TourneysController < Frontend::FrontendController
  before_action :set_tourney, only: %i[ show edit update destroy ]
  before_action :require_permission, only: [:new, :edit, :update, :destroy, :create]

  # GET /tourneys or /tourneys.json
  def index
    @tourneys = Tourney.all
  end
  
  def is_forumpost_valid?(forumpost_id)
    !forumpost_id.match("\d+/").nil? ? true : false
  end
  
  # GET /tourneys/1 or /tourneys/1.json
  def show
    @user = User.find(params[:user_id])
    @tourney = @user.tourneys.find(params[:id])
    @matches = @tourney.matches.all
    @matches = @matches.order("created_at ASC")

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
  def create # Instead of 'find_by' use 'find_or_create_by' -- # Check if entry exists BEFORE doing apirequest
    @user = User.find(params[:user_id])
    # redirect_to(frontend_user_path(@user), notice: "Invalid Forumpost!") if params[:tourney][:forumpost].count("0-9") == 0
    
    # debugger 
    
  
    respond_to do |format|
      
      if params[:tourney][:forumpost].scan(/\d+/).empty? || !params[:tourney][:forumpost].starts_with?("https://osu.ppy.sh/community/forums/topics/")
        flash.now[:notice] = "Invalid Forumpost!"
        format.html { redirect_to frontend_user_path(@user) }
        format.js
        return false
      end
      forumpost_id = params[:tourney][:forumpost].match(/\d+/)[0]
      
      # if !@user.tourneys.exists?(forumpost_id: forumpost_id)
        response = osuApi.getForumpost(forumpost_id)
        data = Tourney.fetchData(response)
        if data.nil?
          flash.now[:notice] = "Invalid Forumpost!"
          format.html { redirect_to frontend_user_path(@user) }
          format.js
          return false
        end


        title = data["title"]
        forumpost_id = data["forumpost_id"]
        spreadsheet = data["spreadsheet"]
        cover_image = data["cover_image"]
        @tourney = @user.tourneys.new(
          title: title,
          forumpost_id: forumpost_id,
          spreadsheet: spreadsheet,
          cover_image: cover_image,
          forumpost: params[:tourney][:forumpost]
        )
        if @tourney.save
          flash.now[:notice] = "Successful!"
          format.html { redirect_to frontend_user_path(@user) }
          format.js
        else
          flash.now[:notice] = "Failed!"
          format.html {redirect_to frontend_user_path(@user), status: :unprocessable_entity }
          # format.js
        end
      # else
      #   flash.now[:notice] = "Already exists!"
      #   format.html { render :new, status: :unprocessable_entity }
      #   format.js
      # end
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
        format.html { redirect_to [:frontend, @user], notice: "Tourney was successfully destroyed." }
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
        redirect_to frontend_user_path(current_user), notice: "Permission Denied!"
      end
    end

    # Only allow a list of trusted parameters through.
    def tourney_params
      params.require(:tourney).permit(:title, :forumpost, :spreadsheet, :forumpost_id)
    end
end

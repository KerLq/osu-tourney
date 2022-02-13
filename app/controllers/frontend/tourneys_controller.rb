class Frontend::TourneysController < Frontend::FrontendController
  before_action :set_tourney, only: %i[ show edit update destroy ]
  before_action :require_permission, only: [:new, :edit, :update, :destroy, :create]
  after_action :save_my_previous_url

  # GET /tourneys or /tourneys.json
  def index
    @tourneys = Tourney.all
  end
  
  def is_forumpost_valid?(forumpost_id)
    !forumpost_id.match("\d+/").nil? ? true : false
  end

  # def forumpost ## WORK TO DO - GET IT WORK!
  #   @user = User.find(params[:user_id])
  #   forumpost_id = params[:tourney][:forumpost]
  #   forumpost_id = forumpost_id.match(/\d+/)[0]
  #   url = URI("https://osu.ppy.sh/api/v2/forums/topics/#{forumpost_id}")
  #   response = apiRequest(url)
  #   title = response['topic']['title']
  #   id = response['topic']['id']
  #   timestamp = response['topic']['created_at']
  #   timestamp = timestamp[0..9]
  #   cover_image = response['posts'][0]['body']['raw']
  #   urls = URI.extract(cover_image, ['http', 'https']) # first element is cover_image
  #   cover_image = urls[0]

  #   spreadsheet = ""
  #   urls.each do |url|
  #     if url.include? "spreadsheets"
  #       spreadsheet = url
  #     end
  #   end

  #   year = timestamp[0..3]
  #   month = timestamp[5..6]
  #   day = timestamp[8..9]

  #   created_at = "#{day}.#{month}.#{year}"

  #   return title, year, month, id, spreadsheet, cover_image, created_at
  # end
  
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
    forumpost_id = params[:tourney][:forumpost].match(/\d+/)[0]
    
    debugger
    response = osuApi.getForumpost(forumpost_id)
    @user = User.find(params[:user_id])

    respond_to do |format|
      if !@user.tourneys.exists?(forumpost_id: forumpost_id)
        fetchedData = Tourney.fetchData(response)
        debugger
        title = fetchedData[0]
        forumpost_id = fetchedData[3]
        spreadsheet = fetchedData[4]
        cover_image = fetchedData[5]
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
            #format.js
          else
            flash.now[:notice] = "Failed!"
            format.html { render :new, status: :unprocessable_entity }
            format.json { render json: @tourney.errors, status: :unprocessable_entity }
            #format.js
          end
      else
        flash.now[:notice] = "Failed!"
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: "error", status: :unprocessable_entity }
        format.js
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

    def save_my_previous_url
      # session[:previous_url] is a Rails built-in variable to save last url.
      session[:my_previous_url] = request.fullpath
    end

    # Only allow a list of trusted parameters through.
    def tourney_params
      params.require(:tourney).permit(:title, :forumpost, :spreadsheet, :forumpost_id)
    end
end

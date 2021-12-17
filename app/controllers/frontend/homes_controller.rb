class Frontend::HomesController < Frontend::FrontendController
    def index
        @news = News.all
        if logged_in?
            @user = current_user
            @tourney = @user.tourneys.new
        end
    end
end

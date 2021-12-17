class Frontend::NewsController < Frontend::FrontendController
    def index
        @news = News.all
    end
    def show
        @news = News.find(params[:id])
    end
end
class Backend::NewsController < Backend::BackendController 

    def index
        @news = News.all
    end
    def show
        @news = News.find(params[:id])
    end

    def update
        @news = News.find(params[:id])

        @news.update(news_params)
    end

    def new
        @news = News.new
    end

    def create
        @news = News.create(news_params)
        redirect_to backend_news_path(@news)
        
    end
    
    def destroy

    end
    private
    def check_if_admin?  
        redirect_to frontend_root_path if !is_admin?
    end

    def news_params
        params.require(:news).permit(
            :cover_image,
            :title,
            :description
        )
    end
end
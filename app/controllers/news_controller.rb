class NewsController < ApplicationController
    before_action :check_if_admin?, :only => [:new, :update, :destroy]

    def index
        @news = News.all
    end
    def show
        @news = News.find(id: params[:id])
    end

    def update
        @news = News.find(id: params[:id])

        @news.update(news_params)
    end

    def destroy

    end
    private
    def check_if_admin?  
        redirect_to root_path if !is_admin?
    end

    def news_params
        params.permit(:news).require (
            :title,
            :description,
            :cover_image
        )
    end
end
class HomesController < ApplicationController
    def index
        @news = News.all
        @user = current_user
        @tourney = @user.tourneys.new
    end
end

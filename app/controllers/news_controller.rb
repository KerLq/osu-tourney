class NewsController < ApplicationController
    before_action :check_if_admin?, :only => [:new, :update, :destroy]

    def check_if_admin?  
        redirect_to root_path if !is_admin?
    end
end
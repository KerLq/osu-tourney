class Frontend::FrontendController < ApplicationController
    
    @@osuApi = nil

    def setOsuApi(oauth)
        @@osuApi = oauth
        if !oauth.nil?
            session[:access_token] = oauth
        end
    end

    def osuApi
        session[:access_token]
    end
end
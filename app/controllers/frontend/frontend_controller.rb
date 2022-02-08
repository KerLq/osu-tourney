class Frontend::FrontendController < ApplicationController
    
    @@osuApi = nil

    def setOsuApi(oauth)
        @@osuApi = oauth 
    end

    def osuApi
        @@osuApi
    end
end
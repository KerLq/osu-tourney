class Frontend::FrontendController < ApplicationController

    @@osuApi = nil

    # def setApi
    #     if session[:access_token] && @@osuApi.nil?
    #         @@osuApi = Osu::Api::Api.new(session[:access_token])
    #     end
    #     debugger
    # end

    def osuApi
        @@osuApi ||= Osu::Api::Api.new(session[:access_token]) if session[:access_token]
    end
end
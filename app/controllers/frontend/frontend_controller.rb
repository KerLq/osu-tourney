class Frontend::FrontendController < ApplicationController
    layout 'frontend'
    @@osuApi = nil

    def osuApi
        @@osuApi ||= Osu::Api::Api.new(session[:access_token]) if session[:access_token]
    end
end
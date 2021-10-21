class ApplicationController < ActionController::Base
    protect_from_forgery

    helper_method :current_user
    helper_method :logged_in?
  
    def current_user
        if session[:user_jwt]
            token = session[:user_jwt][:value]
            debugger
            @username = token['username']
            @avatar_url = token['avatar_url']
        end
    end
  
    def logged_in?    
      session[:user_jwt] != nil
    end
end

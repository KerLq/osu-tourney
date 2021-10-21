class ApplicationController < ActionController::Base
    protect_from_forgery

    helper_method :current_user
    helper_method :logged_in?
  
    def current_user
        if session[:user_id]
            User.find(session[:user_id])
        end
    end
  
    def logged_in?    
      session[:user_id] != nil
    end
end

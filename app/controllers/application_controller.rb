class ApplicationController < ActionController::Base
    protect_from_forgery

    helper_method :current_user
    helper_method :logged_in?
    helper_method :is_admin?
  
    def current_user
        if session[:user_id]
            User.find(session[:user_id])
        end
    end
  
    def logged_in?    
        !!current_user
    end

    def is_admin?
        logged_in? current_user.admin? : false
    end
end

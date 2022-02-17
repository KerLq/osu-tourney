class ApplicationController < ActionController::Base
    protect_from_forgery

    helper_method :current_user
    helper_method :logged_in?
    helper_method :is_admin?
    helper_method :access_token
    helper_method :apiRequest
    helper_method :is_current_user
    helper_method :url_exist?
    
    rescue_from ActiveRecord::RecordNotFound,    with: :render_404
    rescue_from ActionController::RoutingError,  with: :render_404
    rescue_from ActionController::UnknownFormat, with: :render_404

    def render_404
        render :file => "#{Rails.root}/public/404.html"
    end

    def current_user
        User.find(session[:user_id]) if session[:user_id] && User.exists?(id: session[:user_id])
    end

    def is_current_user(user)
        current_user == user ? true : false
    end

    def logged_in?    
        !!current_user
    end

    def is_admin?
        logged_in? ? current_user.admin? : false
    end

    def access_token
        session[:access_token]
    end
end

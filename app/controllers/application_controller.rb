class ApplicationController < ActionController::Base
    protect_from_forgery

    helper_method :current_user
    helper_method :logged_in?
    helper_method :is_admin?
    helper_method :access_token
    helper_method :apiRequest

    rescue_from ActiveRecord::RecordNotFound,    with: :render_404
    rescue_from ActionController::RoutingError,  with: :render_404
    rescue_from ActionController::UnknownFormat, with: :render_404

    def render_404
        render :file => "#{Rails.root}/public/404"
    end

    def current_user
        if session[:user_id]
            User.find(session[:user_id])
        end
    end
  
    def logged_in?    
        !!current_user
    end

    def is_admin?
        logged_in? ? current_user.admin? : false
    end

    def access_token(token)
        if session[:user_id]
            sesssion[:access_token] = token
        end
    end
    def access_token
        session[:access_token]
    end

    def apiRequest(url, params = "")
        if url.nil?
            return "Url nil!"
        end
        if params.nil?
            params = ""
        end
        headers = {
            "Content-Type" => "application/json",
            "Accept" => "application/json",
            "Authorization" => "Bearer #{access_token}"
        }
        response = HTTParty.get(url,
            body: params.to_json,
            headers: headers
        )
        response.parsed_response
    end
end

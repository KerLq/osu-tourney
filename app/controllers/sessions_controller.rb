class SessionsController < ApplicationController
    def register
        @user = User.new
    end
    def create
        @user = User.find_by(username: params[:username])

        if !!@user && @user.authenticate(params[:username])

            session[:user_id] = @user.id
            redirect_to root_path

        else
            message = "Login is invalid!"
            redirect_to root_path, notice: message
            
        end
    end

    def destroy
        session.delete(:user_id)
    end

end

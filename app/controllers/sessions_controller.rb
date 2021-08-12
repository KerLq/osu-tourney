class SessionsController < ApplicationController

    def register
        @user = User.new
    end
    def login
        @user = User.new
    end
    def create
        @user = User.find_by(username: params[:user][:username])

        if !!@user && @user.authenticate(params[:user][:username])

            session[:user_id] = @user.id
            redirect_to root_path

        else
            message = "Login is invalid!"
            #redirect_to root_path, notice: message
            
        end
    end

    def destroy
        session.delete(:user_id)
        redirect_to root_path
    end

end

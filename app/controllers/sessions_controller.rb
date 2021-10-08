class SessionsController < ApplicationController

    def register
        @user = User.new
    end
    def login
        @user = User.new
    end
    def create
        #Hash Password to BCrypt (hash_secure_password) - Watch Wiki or YT
        @user = User.find_by(username: params[:user][:username], email: params[:user][:email], password_digest: params[:user][:password_digest])

        if !!@user && @user.authenticate(params[:user][:username])

            session[:user_id] = @user.id
            redirect_to root_path

        else
            debugger
            message = "Login is invalid!"
            #redirect_to root_path, notice: message
            
        end
    end

    def destroy
        session.delete(:user_id)
        redirect_to root_path
    end

end

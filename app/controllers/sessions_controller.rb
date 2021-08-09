class SessionsController < ApplicationController
    def register

    end
    def create
        @user = User.find_by(username: params[:username])

        if !!@user && @user.authenticate(params[:username])

            session[:user_id] = @user.id
            #redirect_to {homescreen or latest page}

        else
            message = "Login is invalid!"
            #redirect_to {login page}, notice: message
            
        end
    end

    def destroy
        session.delete(:user_id)
    end

end

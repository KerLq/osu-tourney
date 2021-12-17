class Backend::BackendController < ApplicationController
    before_action :permission?

    def permission?
        if !is_admin? 
            redirect_to root_path
        end
    end
end
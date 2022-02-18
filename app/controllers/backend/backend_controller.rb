class Backend::BackendController < ApplicationController
    before_action :permission?
    layout 'backend'
    def permission?
        is_admin? ? true : redirect_to(frontend_root_path)
    end
end
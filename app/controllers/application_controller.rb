class ApplicationController < ActionController::Base
    # load_and_authorize_resource
    before_action :authenticate_user!
    before_action :get_iex
    def after_sign_in_path_for(resource)
        if current_user.admin?
            users_admin_path
        else
            root_path
        end
    end

    def get_iex
        @client ||= IEX::Api::Client.new
    end
end

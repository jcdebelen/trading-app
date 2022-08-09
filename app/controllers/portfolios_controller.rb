class PortfoliosController < ApplicationController
    load_and_authorize_resource
    before_action :authenticate_user!

    def index
    end

    private
    def stock_params
        params.require(:portfolio).permit(:balance, :stock_sym, :stock_quantity, :stock_price)
    end
end

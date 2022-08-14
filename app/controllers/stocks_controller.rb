class StocksController < ApplicationController
  before_action :get_iex

  def index
    search = params[:query] 
    if search.present? && search.match(/[a-zA-Z]/)
      search = search.upcase
      begin
        quote = @client.quote(search)
      rescue
        respond_to do |format|
          format.html { redirect_to stocks_path, alert: 'Symbol not found'}
        end
      else
        @stock = quote
      end
    end
    
  end

  def get_iex
    @client ||= IEX::Api::Client.new
  end

end

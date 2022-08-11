class StocksController < ApplicationController
  before_action :get_iex
  load_and_authorize_resource

  def index
    @stocks = Stock.all
  end

  def get_iex
    @client ||= IEX::Api::Client.new
  end

end

class StocksController < ApplicationController
  before_action :get_iex

  def index
    @stocks = Stock.all
  end

  def get_iex
    @client ||= IEX::Api::Client.new
  end

end

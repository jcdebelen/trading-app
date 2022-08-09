class StocksController < ApplicationController
  load_and_authorize_resource
  before_action :authenticate_user!
  before_action :call_iex, only: [:show]

  def index
    @stocks = Stock.all
  end

  def show
    @stock = Stock.find_by(sym: params[:sym])
    @quote = @client.quote(@stock.sym)
  end

  def to_param
    sym
  end

  private
  def call_iex
    @client = IEX::Api::Client.new
  end

end

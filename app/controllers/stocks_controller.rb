class StocksController < ApplicationController

  def index
    @stocks = Stock.all
  end

  def buy_stock
    
  end

end

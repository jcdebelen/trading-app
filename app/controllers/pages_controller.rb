class PagesController < ApplicationController
  before_action :authenticate_user!

  def home
    @stocks = Stock.all
  end
  
end

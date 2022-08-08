class PagesController < ApplicationController
  before_action :authenticate_user!

  def home
    client = IEX::Api::Client.new
    @symbols = client.ref_data_symbols()
  end
  
end

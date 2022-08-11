class PagesController < ApplicationController
  def home
    @transactions = current_user.transactions
  end
end

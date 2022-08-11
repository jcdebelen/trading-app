class PagesController < ApplicationController
  def home
    @transactions = current_user.transactions.where("stock_quantity != ?", 0)
  end
end

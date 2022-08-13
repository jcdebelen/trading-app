class PagesController < ApplicationController
  def home
    @transactions = current_user.transactions.where("stock_quantity != ?", 0)
    @pending_stocks = current_user.transactions.where(status: "pending")
  end

  def completed
  end

  def pending
  end
  
  def history
    @histories = current_user.user_histories.where.not(symbol: nil).order(created_at: :desc)
  end
end

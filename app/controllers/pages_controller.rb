class PagesController < ApplicationController
  def home
    @transactions = current_user.transactions.where("stock_quantity != ?", 0)
    StatusJob.set(wait: 5.seconds).perform_later(params[:TR_ID])

  end

  def completed
  end

  def pending
  end
  
  def history
    @histories = current_user.user_histories.where.not(symbol: nil).order(created_at: :desc)
  end
end

class PagesController < ApplicationController
  before_action :get_iex
  def home
    if params[:TR_Q].present?
      @pending = Pending.create(user_id: current_user.id, symbol: params[:TR_S], quantity: params[:TR_Q], amount: params[:TR_A])
      @pending.save
      DeleteJob.set(wait: 10.seconds).perform_later(@pending.id)
      respond_to do |format|
        format.html{ redirect_to root_path, notice: "#{params[:TR_Q]} #{params[:TR_S]}, has been added to pending stage"}
      end
    end
    @transactions = current_user.transactions.where("stock_quantity > ?", 0)
    @pending_stocks = current_user.pendings

    if params[:TR_S].present?
      @sum = params[:TR_A]
    end
  end

  def completed
  end

  def pending
  end

  def history
    @histories = current_user.user_histories.where.not(symbol: nil).order(created_at: :desc)
  end

  def not_found
  end

  def get_iex
    @client ||= IEX::Api::Client.new
  end

end

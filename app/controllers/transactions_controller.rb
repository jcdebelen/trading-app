class TransactionsController < ApplicationController
  before_action :get_iex
  load_and_authorize_resource
  #SS - Stock Symbol, SID -  Stock ID, TR_ID - Transaction_ID
  def buy
    @quote = @client.quote(params[:SS])
    stock = current_user.transactions.find_by(symbol: (params[:SS]))
    if stock.present?
      @stock = stock
    else
      @stock_symbol = params[:SS]
    end
  end

  def sell
    @transaction = current_user.transactions.find(params[:id])
  end

  def create
    sum = (params[:stock_price]).to_i * (params[:stock_quantity]).to_i
    respond_to do |format|
      if current_user.balance < sum
        format.html { redirect_to root_path, notice: "Insufficient balance, add more!" }
      else
        current_user.user_histories.create(status: params[:ticker], symbol: params[:symbol], amount: sum)
        @find_duplicate = current_user.transactions.find_by(symbol: params[:symbol])
        current_user.balance -= sum
        current_user.save
        if @find_duplicate.present?
          quantity = params[:stock_quantity].to_i
          StatusJob.set(wait: 10.seconds).perform_later(@find_duplicate.id, quantity)
          # TR_ID = Transaction ID, TR:S, Transaction Symbol, TR_A = Transaction Amount, TR_Q = Transaction Quantity
          format.html { redirect_to root_path(
            TR_S: @find_duplicate.symbol,
            TR_Q: params[:stock_quantity],
            TR_A: sum)}
        else
          CreateJob.set(wait: 10.seconds).perform_later(transaction_params)
          format.html { redirect_to root_path(
            TR_S: params[:symbol],
            TR_Q: params[:stock_quantity],
            TR_A: sum
            ) }
        end
      end
    end
  end

  def destroy
    t = params[:transaction]
    sum = (@transaction.stock_price) * (t[:stock_quantity]).to_i
    @transaction = current_user.transactions.find(params[:id])
    current_user.user_histories.create(status: t[:ticker], symbol: t[:symbol], amount: sum)
    respond_to do |format|
      @transaction.stock_quantity -= (t[:stock_quantity]).to_i
      current_user.balance += sum
      current_user.save
      @transaction.save
      format.html { redirect_to root_path, notice: "Successfully sell #{t[:stock_quantity]} #{@transaction.symbol} stock +$#{sum}" }
    end
    
  end

  private
  def transaction_params
    params.permit(:user_id, :completed, :ticker, :symbol, :company_name, :stock_price, :stock_quantity, :user_id)
  end

  def get_iex
    @client ||= IEX::Api::Client.new
  end

end

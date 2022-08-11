class TransactionsController < ApplicationController
  before_action :get_iex
  load_and_authorize_resource

  def buy
    @quote = @client.quote(params[:SS])
    @stock = current_user.transactions.find_by(stock_id: (params[:SID]).to_i )
  end

  def sell
    @transaction = current_user.transactions.find(params[:id])
  end

  def create
    respond_to do |format|
      if current_user.balance < (params[:stock_price]).to_i
        format.html { redirect_to root_path, notice: "Insufficient balance, add more!" }
      else
        @find_duplicate = current_user.transactions.find_by(symbol: params[:symbol])
        current_user.balance -= (params[:stock_price]).to_i * (params[:stock_quantity]).to_i
        current_user.save
        if @find_duplicate.present?
          @find_duplicate.stock_quantity += params[:stock_quantity].to_i
          @find_duplicate.save
        else
          @transaction = Transaction.create(transaction_params)
        end
        format.html { redirect_to root_path, notice: "You've bought #{params[:stock_quantity]} #{params[:symbol]} -$#{(params[:stock_price]).to_i * (params[:stock_quantity]).to_i}"}
      end
    end
  end

  def destroy
    @transaction = current_user.transactions.find(params[:id])
    respond_to do |format|
      @transaction.stock_quantity -= (params[:transaction][:stock_quantity]).to_i
      current_user.balance += (@transaction.stock_price) * (params[:transaction][:stock_quantity]).to_i
      current_user.save
      @transaction.save
      format.html { redirect_to root_path, notice: "Successfully sell #{params[:transaction][:stock_quantity]} #{@transaction.symbol} stock +$#{(@transaction.stock_price) * (params[:transaction][:stock_quantity]).to_i}" }
    end
    
  end

  private
  def transaction_params
    params.permit(:ticker, :symbol, :company_name, :stock_id, :stock_price, :stock_quantity, :user_id)
  end

  def get_iex
    @client ||= IEX::Api::Client.new
  end

end

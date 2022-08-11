class TransactionsController < ApplicationController
  before_action :get_iex

  def buy
    @quote = @client.quote(params[:TS])
    @symbol_id = params[:TID]
  end

  def sell
    @transaction = current_user.transactions.find(params[:id])
  end

  def create
    @find_duplicate = current_user.transactions.find_by(symbol: params[:symbol])
    
    respond_to do |format|
      if @find_duplicate.present?
        @find_duplicate.stock_quantity += params[:stock_quantity].to_i
        @find_duplicate.save
        format.html { redirect_to root_path, notice: "Stock #{@find_duplicate.symbol} quantity was successfully updated" }
      else
        @transaction = Transaction.create(transaction_params)
        format.html { redirect_to root_path, notice: "Stock #{params[:symbol]} was successfully added to portfolio" }
      end
    end
  end

  def destroy
    @transaction = current_user.transactions.find(params[:id])
    respond_to do |format|
      if @transaction.stock_quantity > 1
        @transaction.stock_quantity -= (params[:transaction][:stock_quantity]).to_i
        @transaction.save
        format.html { redirect_to root_path, notice: "Successfully sell #{params[:transaction][:stock_quantity]} #{@transaction.symbol} stock" }
      else
        @transaction.destroy
        format.html { redirect_to root_path, notice: "Stock #{@transaction.symbol} was successfully deleted" }
      end
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

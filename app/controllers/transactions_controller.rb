class TransactionsController < ApplicationController
  before_action :get_iex

  def create
    @find_duplicate = Transaction.find_by(symbol: params[:symbol])
    if @find_duplicate.present?
      @find_duplicate.stock_quantity += 1
      @find_duplicate.save

      respond_to do |format|
        format.html { redirect_to root_path, notice: "Stock #{@find_duplicate.company_name} quantity was successfully updated" }
      end

    else
      @transaction = Transaction.create(ticker: params[:ticker],
        symbol: params[:symbol],
        company_name: params[:company_name],
        stock_id: params[:stock_id],
        stock_price: params[:stock_price],
        stock_quantity: 1,
        user_id: params[:user_id]
    )

    respond_to do |format|
      format.html { redirect_to root_path, notice: "Stock #{params[:company_name]} was successfully added to portfolio" }
    end

    end
    
  end

  def destroy
    @transaction = Transaction.find(params[:id])
    if @transaction.stock_quantity > 1
      @transaction.stock_quantity -= 1
      @transaction.save
      respond_to do |format|
        format.html { redirect_to root_path, notice: "Stock #{@transaction.company_name} was successfully deleted stock" }
      end
    else
      @transaction.destroy
      respond_to do |format|
        format.html { redirect_to root_path, notice: "Stock #{@transaction.company_name} was successfully deleted" }
      end
    end
    
  end

  def get_iex
    @client ||= IEX::Api::Client.new
  end

end

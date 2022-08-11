class TransactionsController < ApplicationController

  def create
    @find_duplicate = current_user.transactions.find_by(symbol: params[:symbol])
    
    respond_to do |format|
      if @find_duplicate.present?
        @find_duplicate.stock_quantity += params[:stock_quantity].to_i
        @find_duplicate.save
        format.html { redirect_to root_path, notice: "Stock #{@find_duplicate.company_name} quantity was successfully updated" }
      else
        @transaction = Transaction.create(transaction_params)
        format.html { redirect_to root_path, notice: "Stock #{params[:company_name]} was successfully added to portfolio" }
      end
    end
  end

  def destroy
    @transaction = current_user.transactions.find(params[:id])
    respond_to do |format|
      if @transaction.stock_quantity > 1
        @transaction.stock_quantity -= 1
        @transaction.save
        format.html { redirect_to root_path, notice: "Stock #{@transaction.company_name} was successfully deleted stock" }
      else
        @transaction.destroy
        format.html { redirect_to root_path, notice: "Stock #{@transaction.company_name} was successfully deleted" }
      end
    end
    
  end

  private
  def transaction_params
    params.permit(:ticker, :symbol, :company_name, :stock_id, :stock_price, :stock_quantity, :user_id)
  end

end

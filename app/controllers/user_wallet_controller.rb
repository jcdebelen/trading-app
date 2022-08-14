class UserWalletController < ApplicationController
  def deposit
  end

  def withdraw
  end

  def create
    respond_to do |format|
      if params[:withdraw].present?
        if params[:withdraw].to_f > current_user.balance.to_f
          format.html { redirect_to root_path, notice: "Insufficient balance"}
        else
          current_user.user_histories.create(status: params[:commit], amount: params[:withdraw])
          current_user.balance -= params[:withdraw].to_f 
          format.html { redirect_to root_path, notice: "You've successfully withdraw $#{params[:withdraw]}"}
          current_user.save
        end
      elsif params[:deposit].present?
        current_user.user_histories.create(status: params[:commit], amount: params[:deposit])
        current_user.balance += params[:deposit].to_f 
        format.html { redirect_to root_path, notice: "You've successfully deposited $#{params[:deposit]}"}
        current_user.save
      end
    end
  end

end

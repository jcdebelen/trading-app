class UserWalletController < ApplicationController

  def deposit
  end

  def withdraw
  end

  def create
    respond_to do |format|
      if params[:withdraw].present?
        if current_user.balance < params[:withdraw].to_i
          format.html { redirect_to root_path, notice: "You cannot withdraw more than your balance, try again"}
        else
          current_user.balance -= params[:withdraw].to_i 
          format.html { redirect_to root_path, notice: "You've successfully withdraw $#{params[:withdraw]}"}
          current_user.save
        end
      elsif params[:deposit].present?
        current_user.balance += params[:deposit].to_i 
        format.html { redirect_to root_path, notice: "You've successfully deposited $#{params[:deposit]}"}
        current_user.save
      end
    end
  end

end

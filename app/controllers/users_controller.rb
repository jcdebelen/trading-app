class UsersController < ApplicationController
  load_and_authorize_resource
  before_action :set_user, only: %i[ show edit update destroy ]

  def index
      @users_not_approved = User.where(approved: false)
      @users_approved = User.where(approved: true, role: "trader")
  end

  def show
    check_if_exist = UserHistory.where(user_id: params[:id]).order(created_at: :desc)
    if check_if_exist.present?
      @user_history = check_if_exist
    end
  end

  def admin_new
    @user = User.new
  end

  def admin_create
    @user = User.new(user_params)
    respond_to do |format|
      if @user.save
        format.html { redirect_to users_path, notice: "User was successfully created."}
      else
        format.html { render :admin_new, status: :unprocessable_entity}
      end
    end
  end

  def edit
  end

  def update
    @user = User.find(params[:id])
    respond_to do |format|
      if @user.update(user_params)
        if @user.approved?
          UserMailer.user_message_approved(@user.email).deliver
        end
        format.html { redirect_to users_path, notice: "User was successfully updated." }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    respond_to do |format|
      if @user.destroy
        format.html { redirect_to users_path, notice: "User was successfully deleted" }
      end
    end
  end

  private
  
  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation, :approved)
  end

end

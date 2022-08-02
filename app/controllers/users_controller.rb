class UsersController < ApplicationController
  load_and_authorize_resource
  before_action :authenticate_user!
  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
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
        format.html { render :admin_new, status: :unprocessable_entity }
      end
    end
  end

  def edit
  end

  def destroy
  end

  private

  def user_params
    params.require(:user).permit(:email, :password)
  end

end

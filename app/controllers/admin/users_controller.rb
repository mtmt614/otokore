class Admin::UsersController < ApplicationController
  
  def index
    @users = User.page(params[:page])
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @userr = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to admin_user_path(params[:id])
    else
      render :edit
    end
  end


  private
  def user_params
    params.require(:user).permit(:name, :email, :is_deleted, :profile_image)
  end
  
end

class Admin::UsersController < ApplicationController
  
  def index
    @users = User.page(params[:page]).per(5)
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts.order('created_at DESC').page(params[:page]).per(8)
  end

  def edit
    @user = User.find(params[:id])
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

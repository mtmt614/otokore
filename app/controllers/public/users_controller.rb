class Public::UsersController < ApplicationController
  
  before_action :set_user, only: [:likes]

  def show
    @user = User.find(params[:id])
    @posts = @user.posts.page(params[:page])
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    @user.update(user_params)
    redirect_to users_my_page_path(@user.id)
  end

  def unsubscribe
    @user = current_user
  end

  def withdraw
    @user = current_user
    @user.update(is_deleted: true)
    reset_session
    redirect_to root_path
  end
  
  def likes
    @user = User.find(params[:id])
    likes= Like.where(user_id: @user.id).pluck(:post_id)
    @like_posts = Post.find(likes)
  end


  private

  def user_params
    params.require(:user).permit(:name, :email, :encrypted_password, :profile_image, :is_deleted)
  end
  
  def set_user
    @user = User.find(params[:id])
  end
  
end

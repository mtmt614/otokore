class Public::UsersController < ApplicationController
  
  before_action :set_user, only: [:likes]
  before_action :ensure_guest_user, only: [:edit, :withdraw]

  def show
    @user = User.find(params[:id])
    @posts = @user.posts.order('created_at DESC').page(params[:page]).per(8)
  end

  def edit
    @user = current_user
  end

  def update
    @user = User.find(current_user.id)
    if @user.update(user_params)
      flash[:notice] = "会員情報を変更しました"
      redirect_to user_path
    else
      render :edit
    end
  end

  def unsubscribe
    @user = current_user
  end

  def withdraw
    @user = current_user
    @user.update(is_deleted: true)
    reset_session
    flash[:notice] = "退会しました"
    redirect_to root_path
  end
  
  def likes
    @user = User.find(params[:id])
    likes = Like.where(user_id: @user.id).pluck(:post_id)
    @like_posts = Post.where(id: likes).order('created_at DESC').page(params[:page]).per(8)
  end


  private
  
  def user_params
    params.require(:user).permit(:name, :email, :encrypted_password, :profile_image, :is_deleted)
  end
  
  def set_user
    @user = User.find(params[:id])
  end
  
  def ensure_guest_user
    
    @user = current_user
    if @user.email == "guest@email.com"
      #binding.pry
      redirect_to user_path(current_user) , notice: 'ゲストユーザーはこの操作を行うことができません。'
    end
  end  
  
end

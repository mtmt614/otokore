class Public::LikesController < ApplicationController
  before_action :ensure_guest_user, only: [:create, :destroy]
  
  def create
    post = Post.find(params[:post_id])
    like = current_user.likes.new(post_id: post.id)
    like.save
    redirect_to post_path(post)
  end

  def destroy
    post = Post.find(params[:post_id])
    like = current_user.likes.find_by(post_id: post.id)
    like.destroy
    redirect_to post_path(post)
  end
  
  private
  
  def ensure_guest_user
    if current_user.email == "guest@email.com"
      redirect_to user_path(current_user) , notice: 'ゲストユーザーはこの操作を行うことができません。'
    end
  end  
  
end

class Public::CommentsController < ApplicationController
  before_action :ensure_guest_user, only: [:create, :destroy]

  def create
    post = Post.find(params[:post_id])
    comment = current_user.comments.new(comment_params)
    comment.post_id = post.id
    comment.save
    redirect_to post_path(params[:post_id])
  end

  def destroy
    post = Post.find(params[:post_id])
    @comments = post.comments.page(params[:page]).per(3)
    current_user.comments.find(params[:id]).destroy!
    flash[:notice] = 'コメントを削除しました'
    redirect_to post_path(params[:post_id])
  end

  private
  def comment_params
    params.require(:comment).permit(:body)
  end

  def ensure_guest_user
    if current_user.email == "guest@email.com"
      redirect_to user_path(current_user) , notice: 'ゲストユーザーはこの操作を行うことができません。'
    end
  end

end

class Admin::CommentsController < ApplicationController
  
  def destroy
    Comment.find(params[:id]).destroy
    flash[:notice] = 'コメントを削除しました'
    redirect_to admin_post_path(params[:post_id])
  end
  
  
  private
  def comment_params
    params.require(:comment).permit(:body)
  end
  
end

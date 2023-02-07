class Public::PostsController < ApplicationController
  
  def new
    @post = Post.new
  end
  
  private
   def post_params
     params.require(:post).permit(:title, :artist, :content, :genre_id,)
   end
  
end

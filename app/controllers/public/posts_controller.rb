class Public::PostsController < ApplicationController

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
     if @post.save!
       redirect_to posts_path
     else
       render :new
     end
  end

  def index
    @genres = Genre.all
    @all_posts = Post.all
    @posts = Post.page(params[:page]).per(10)
  end

  def show
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      redirect_to public_post_path(@post)
    else
      render :edit
    end
  end

  private
   def post_params
     params.require(:post).permit(:title, :artist, :content, :genre_id)
   end

end

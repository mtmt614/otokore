class Public::PostsController < ApplicationController
  before_action :ensure_guest_user, only: [:create]

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
     if @post.save
      # flash[:notice] = "投稿が成功しました"
       redirect_to posts_path, notice: "投稿が成功しました"
     else
       render :new
     end
  end

  def index
    @genres = Genre.page(params[:page])
    if params[:genre_id].present?
      @genre = Genre.find(params[:genre_id])
      @posts = @genre.posts.order('created_at DESC').page(params[:page]).per(8)
    else
      @posts = Post.order('created_at DESC').page(params[:page]).per(8)
    end
  end

  def show
    @post = Post.(params[:id])
    @comment = Comment.new
    @comments = Comment.all.page(params[:page]).per(3)
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      flash[:notice] = "編集を適用しました"
      redirect_to post_path(@post)
    else
      render :edit
    end
  end

  def destroy
    if @post = Post.find(params[:id]).destroy
      flash[:notice] = "投稿を削除しました"
      redirect_to posts_path
    else
      redirect_to "/"
    end
  end

  private

   def post_params
     params.require(:post).permit(:title, :artist, :content, :genre_id, :image)
   end

   def ensure_guest_user
    if current_user.email == "guest@email.com"
      redirect_to user_path(current_user)
    end
   end

end

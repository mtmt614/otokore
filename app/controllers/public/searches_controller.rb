class Public::SearchesController < ApplicationController
  def search
    @word_for_search = params[:word_for_search]
    @posts = Post
      .where("title LIKE ? or artist LIKE ? or content LIKE ?", "%#{@word_for_search}%", "%#{@word_for_search}%", "%#{@word_for_search}%")
      .eager_load(:user, :likes, :comments)
      .page(params[:page])
      .per(10)
      .reverse_order
  end
end

class Admin::GenresController < ApplicationController
  
  def index
    @genre = Genre.new
    @genres = Genre.all.page(params[:page]).per(4)
  end
  
  def edit
    @genre = Genre.find(params[:id])
  end
  
  def create
    @genre = Genre.new(genre_params)
    if @genre.save
      redirect_to admin_genres_path
    else
      @genres = Genre.page(params[:page])
      render :index
    end
  end
  
  def update
    @genre = Genre.find(params[:id])
    if @genre.update(genre_params)
      redirect_to admin_genres_path
    else
      render :edit
    end
  end
  
private
def genre_params
    params.require(:genre).permit(:genrename)
end

end

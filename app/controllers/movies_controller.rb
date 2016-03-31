class MoviesController < ApplicationController
  def index

    @movies = Movie.all

    if params[:title]
      @movies = @movies.where("title LIKE ? AND director LIKE ? OR runtime_in_minutes LIKE ?", "%#{params[:title]}%", "%#{params[:director]}%", "%#{params[:runtime_in_minutes]}%")
    end
    if params[:director]
      @movies = @movies.where("director LIKE ?", "%#{params[:director]}%")
    end
    if params[:runtime_in_minutes]
      if params[:runtime_in_minutes] == "90"
        @movies = @movies.where("runtime_in_minutes < ?", "%#{params[:runtime_in_minutes]}%")
      elsif params[:runtime_in_minutes] == "120"
        @movies = @movies.where("runtime_in_minutes > ?", "%#{params[:runtime_in_minutes]}%")
      else
        minutes = params[:runtime_in_minutes].split('-')
        @movies = @movies.where("runtime_in_minutes BETWEEN ? and ?", "%#{minutes[0].to_i}%", "%#{minutes[1].to_i}%" )
      end
    end

  end

  def show
    @movie = Movie.find(params[:id])
  end

  def new
    @movie = Movie.new
  end

  def edit
    @movie = Movie.find(params[:id])
  end

  def create
    @movie = Movie.new(movie_params)
    if @movie.save
      redirect_to movies_path, notice: "#{@movie.title} was submitted successfully"
    else
      render :new
    end
  end

  def update
    @movie = Movie.find(params[:id])
    if @movie.update_attributes(movie_params)
      redirect_to movie_path(@movie)
    else
      render :edit
    end
  end

  def destroy 
    @movie = Movie.find(params[:id])
    @movie.destroy
    redirect_to movies_path
  end

  private

  def movie_params
    params.require(:movie).permit(:title, :release_date, :director, :runtime_in_minutes, :image, :remove_image, :description)
  end
end

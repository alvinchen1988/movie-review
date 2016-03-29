class ReviewsController < ApplicationController

  before_filter :load_movie, :restrict_access

  def new
    # @review = Review.new(movie_id: @movie.id)
    @review = @movie.reviews.build #same as above but more concise
  end

  def create
    @review = @movie.reviews.build(review_params)
    @review.user_id = current_user.id

    if @review.save
      redirect_to @movie, notice: "Review created successfully"
    else
      render :new
    end
  end

  private

  def load_movie
    @movie = Movie.find(params[:movie_id])
  end

  def review_params
    params.require(:review).permit(:text, :rating_out_of_ten)
  end
end

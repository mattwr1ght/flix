class ReviewsController < ApplicationController
    before_action :find_movie

    def index
        @movie = find_movie
        @reviews = @movie.reviews 
    end

    def new
        @movie = find_movie
        @review = Review.new
    end

    def create
        @movie = find_movie
        @review = @movie.reviews.new(review_params)
        if @review.save
            redirect_to movie_reviews_path , notice: "Review successfully saved!"
        else
            render :new
        end
    end

    private

    def find_movie
        Movie.find(params[:movie_id])
    end

    def review_params
        params.require(:review)
            .permit(:name, :stars, :comment)
    end
    

end

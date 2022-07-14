class MoviesController < ApplicationController
    before_action :require_signin, except: [:index, :show]
    before_action :require_admin, except: [:index, :show]

    def index
        @movies = Movie.released
    end

    def show
        @movie = get_movie
        @fans = @movie.fans
    end

    def edit
        @movie = get_movie
    end

    def update
        @movie = get_movie
        if @movie.update(movie_params)
            redirect_to @movie, notice: "Movie successfully updated!"
        else
            render :edit
        end
    end

    def new
        @movie = Movie.new  
    end

    def create 
        @movie = Movie.new  
        if @movie.update(movie_params)
            redirect_to @movie, notice: "Movie successfully created!"
        else
            render :new
        end
    end

    def destroy
        @movie = get_movie
        @movie.destroy
        redirect_to movies_url, alert: "Movie successfully deleted!"
    end

    private

    def get_movie
        Movie.find(params[:id])
    end

    def movie_params
        params.require(:movie)
            .permit(:title, :description, :rating, :released_on, :total_gross, :director, :image_file_name, :duration)
    end
end

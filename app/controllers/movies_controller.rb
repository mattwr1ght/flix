class MoviesController < ApplicationController
    before_action :require_signin, except: [:index, :show]
    before_action :require_admin, except: [:index, :show]
    before_action :get_movie, only: [:show, :edit, :update, :destroy]


    def index
        case params[:filter]
        when "upcoming"
          @movies = Movie.upcoming
        when "recent"
          @movies = Movie.recent
        else
          @movies = Movie.released
        end
    end

    def show
        @fans = @movie.fans
        @genres = @movie.genres.order(:name)
        if current_user
            @favorite = current_user.favorites.find_by(movie: @movie)
        end
    end

    def edit
    end

    def update
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
        @movie.destroy
        redirect_to movies_url, alert: "Movie successfully deleted!"
    end

    private

    def get_movie
        @movie = Movie.find_by!(slug: params[:id])
    end

    def movie_params
        params.require(:movie)
            .permit(:title, :description, :rating, :released_on, :total_gross, :director, :main_image, :duration, genre_ids: [])
    end
end

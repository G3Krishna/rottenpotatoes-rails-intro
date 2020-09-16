class MoviesController < ApplicationController

  def movie_params
    params.require(:movie).permit(:title, :rating, :description, :release_date)
  end
  
  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end

  def index
    @movies = Movie.all
    
    #to store the name of column to be sorted
    column_to_be_sorted = params[:column_to_be_sorted]
    if(!column_to_be_sorted)
      column_to_be_sorted = session[:column_to_be_sorted]
    end
    
    #to store the column that was sorted for the next operation
    session[:column_to_be_sorted]= column_to_be_sorted
    #sort operation
    @movies = Movie.order(column_to_be_sorted)
    #to store the available ratings
    @all_ratings = ['G','R','PG','PG-13']
    #stores the ratings that was filtered by the user
    @filtered_rating = params[:ratings]
    if(!@filtered_rating)
      @filtered_rating=session[:ratings]
    end
    #stores the key values of the hash 'ratings' 
    if(@filtered_rating)
      @filtered_rating_keys = @filtered_rating.keys
    else
      @filtered_rating_keys = @all_ratings
    end
    #stores the ratings that were filtered by the user if needed for the next operation
    session[:ratings]=@filtered_rating
    #sorts the list of movies with given filtered ratings
    @movies = Movie.where(rating: @filtered_rating_keys).order(column_to_be_sorted)

    
  end

  def new
    # default: render 'new' template
  end

  def create
    @movie = Movie.create!(movie_params)
    flash[:notice] = "#{@movie.title} was successfully created."
    redirect_to movies_path
  end

  def edit
    @movie = Movie.find params[:id]
  end

  def update
    @movie = Movie.find params[:id]
    @movie.update_attributes!(movie_params)
    flash[:notice] = "#{@movie.title} was successfully updated."
    redirect_to movie_path(@movie)
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    flash[:notice] = "Movie '#{@movie.title}' deleted."
    redirect_to movies_path
  end

end
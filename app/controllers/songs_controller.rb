require 'rack-flash'

class SongsController < ApplicationController
  use Rack::Flash

  get '/songs' do
    @songs = Song.all
    erb :'/songs/index'
  end


  get '/songs/new' do
    erb :'/songs/new'
  end

  post '/songs/new' do
    @song = Song.create(name: params["Name"])

    if Artist.find_by(name: params["Artist Name"]).nil?
      @artist = Artist.create(name: params["Artist Name"])
      @song.artist = @artist
    else
      @song.artist = Artist.find_by(name: params["Artist Name"])
    end
    @song.save
binding.pry
    if params["genre_name"].empty?
      params[:genres].each {|genre_name| @song.song_genres.create(genre: params[:genre_name])}
    else
      @song.song_genres.create(genre: params[:genre_name])
    end
    @song.save

    flash[:message] = "Successfully created song."
    redirect to "/songs/#{@song.slug}"
  end

  get '/songs/:slug' do
    if Song.find_by_slug(params[:slug]).nil?
      "No song is found"
    else
      @song = Song.find_by_slug(params[:slug])
      erb :'/songs/show'
    end
  end

  # get '/songs/:slug/edit' do
  #   if Song.find_by_slug(params[:slug]).nil?
  #     "No song is found"
  #   else
  #     @song = Song.find_by_slug(params[:slug])
  #     erb :'/songs/edit'
  #   end
  # end
  #
  # post '/songs/:slug/edit' do
  #   @song = Song.create(name: params["Name"])
  #
  #   if Artist.find_by(name: params["Artist Name"]).nil?
  #     @artist = Artist.create(name: params["Artist Name"])
  #     @song.artist = @artist
  #   else
  #     @song.artist = Artist.find_by(name: params["Artist Name"])
  #   end
  #   @song.save

    # if params["genre_name"].empty?
    #   @song.genres.update(params[:genres])
    # else
    #   @song.song_genres.create(genre: params[:genres])
    # end
    # @song.save


  #   flash[:message] = "Successfully updated song."
  #   redirect to "/songs/#{@song.slug}"
  # end

end

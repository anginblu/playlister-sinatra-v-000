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

    if params["genre_name"].empty?
      params[:genres].each do |id|
        @genre = Genre.find(id)
        @song.song_genres.create(genre: @genre)
      end
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

  get '/songs/:slug/edit' do
    if Song.find_by_slug(params[:slug]).nil?
      "No song is found"
    else
      @song = Song.find_by_slug(params[:slug])
      erb :'/songs/edit'
    end
  end

  post '/songs/:slug' do
    # @song = Song.find_by(name: params["Artist Name"])

    if !Artist.find_by(name: params["Artist Name"]).nil?
      @artist = Artist.create(name: params["Artist Name"])
      @song.artist = @artist
      @song.save
    else
      @song = Song.find_by(name: params["Artist Name"])
    end

    if params["genre_name"].empty?
      binding.pry
      @song.genres = []
      params[:genres].each do |id|
        @genre = Genre.find(id)
        @song.song_genres.create(genre: @genre)
      end
    else
      @song.song_genres.create(genre: params[:genre_name])
    end
    @song.save

    flash[:message] = "Successfully updated song."
    redirect to "/songs/#{@song.slug}"
  end

end

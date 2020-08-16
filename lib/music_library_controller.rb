class MusicLibraryController

  attr_accessor :path

  @library = ""

  def initialize(path = './db/mp3s')
    @path = path
    # binding.pry
    @library = MusicImporter.new(@path).import
  end

  def call
    input = ""
    until input == "exit"
      puts "Welcome to your music library!"
      puts "To list all of your songs, enter 'list songs'."
      puts "To list all of the artists in your library, enter 'list artists'."
      puts "To list all of the genres in your library, enter 'list genres'."
      puts "To list all of the songs by a particular artist, enter 'list artist'."
      puts "To list all of the songs of a particular genre, enter 'list genre'."
      puts "To play a song, enter 'play song'."
      puts "To quit, type 'exit'."
      puts "What would you like to do?"
      input = gets.chomp

      case input
      when "list songs"
        list_songs
      when "list artists"
        list_artists
      when "list genres"
        list_genres
      when "list artist"
        list_songs_by_artist
      when "list genre"
        list_songs_by_genre
      when "play song"
        play_song
      end
    end
  end

  def list_songs
    songs = Song.all.sort_by{|s| s.name}
    songs.each.with_index(1){|s, i| puts "#{i}. #{s.artist.name} - #{s.name} - #{s.genre.name}"}
  end

  def list_artists
    artists = Artist.all.sort_by{|a| a.name}
    artists.each.with_index(1){|a, i| puts "#{i}. #{a.name}"}
  end

  def list_genres
    genre = Genre.all.sort_by{|g| g.name}
    genre.each.with_index(1){|g, i| puts "#{i}. #{g.name}"}
  end

  def list_songs_by_artist
    puts "Please enter the name of an artist:"
    input = gets.chomp

    if artist = Artist.find_by_name(input)
      artist.songs.sort_by{|s| s.name}.each.with_index(1){|s, i| puts "#{i}. #{s.name} - #{s.genre.name}"}
    end
  end

  def list_songs_by_genre
    puts "Please enter the name of a genre:"
    input = gets.chomp

    if genre = Genre.find_by_name(input)
      genre.songs.sort_by{|s| s.name}.each.with_index(1){|s, i| puts "#{i}. #{s.artist.name} - #{s.name}"}
    end
  end

  def play_song
    puts "Which song number would you like to play?"
    input = gets.chomp.to_i
    songs = Song.all.sort_by{|s| s.name}

    # unless input >= songs.length
    unless songs[input-1] == nil || input < 1 || input >= songs.length
      puts "Playing #{songs[input-1].name} by #{songs[input-1].artist.name}"
    end
  end


end

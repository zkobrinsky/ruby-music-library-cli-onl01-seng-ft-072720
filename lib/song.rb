class Song
  extend Concerns::Findable

  attr_accessor :name
  attr_reader :artist, :genre

  @@all = []

  def initialize(name, artist = nil, genre = nil)
    @name = name
    self.artist = artist if artist
    self.genre = genre if genre
    # save
  end

  def save
    @@all << self
  end

  def self.all
    @@all
  end

  def self.destroy_all
    @@all.clear
  end

  def self.create(name)
    # self.new(name)
    inst = self.new(name).tap {|inst| inst.save}
  end

  def artist=(artist)
    @artist = artist
    artist.add_song(self)
  end

  def genre=(genre)
    @genre = genre
    genre.songs << self unless genre.songs.include? self
  end

  def self.new_from_filename(filename)
    name = filename.split(" - ")[1]
    artist = (filename.split(" - ")[0])
    genre = (filename.split(" - ")[2]).split(".")[0]

    artist = Artist.find_or_create_by_name(artist)
    genre = Genre.find_or_create_by_name(genre)
    new(name, artist, genre)
    # binding.pry
  end

  def self.create_from_filename(filename)
    song = new_from_filename(filename)
    # unless Song.all.include?(song)
      song.save
    # end
  end


end
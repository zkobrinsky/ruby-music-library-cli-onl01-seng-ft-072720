class Artist
  extend Concerns::Findable

  attr_accessor :name

  @@all = []

  def initialize(name)
    @name = name
    @songs = []
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
    inst = self.new(name).tap {|inst| inst.save}
  end

  def songs
    @songs
  end

  def add_song(song)
    unless song.artist == self
      song.artist = self
       @songs << song unless @songs.include?(song)
    end
  end

  def genres
    artists = Song.all.select{|s| s.artist}
    artists.collect{|a| a.genre}.uniq
  end

end

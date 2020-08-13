class Genre

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
    unless song.genre != nil
      song.genre = self
      @songs << song
    end
  end

end

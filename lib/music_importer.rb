class MusicImporter
  attr_accessor :path

  def initialize(path)
    @path = path
  end

  def files
    Dir.glob("#{path}/*.mp3").collect{|song| song.gsub("#{path}/", "")}
  end

  def import
    files.each{|f| Song.create_from_filename(f)}
  end

end

#importsession = MusicImporter.new('./spec/fixtures/mp3s')
#'./spec/fixtures/mp3s
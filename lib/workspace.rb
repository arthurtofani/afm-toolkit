class Workspace
  attr_accessor :name, :audios

  def self.create(dest_folder, name)
    w = Workspace.new(dest_folder)
    w.name = name
    w.configure
  end

  def self.load(folder)
    r = File.open("#{folder}/workspace.yml"){|f| YAML::load(f) }
    r.load_audios
    r
  end

  def initialize(folder)
    @folder = folder
    @audios = []
  end

  def temp_folder
    "#{@folder}/temp"
  end

  def audios_folder
    "#{@folder}/audios"
  end


  def add_audio(source_file_path, name)
    new_folder = "#{@folder}/audios/#{name}"
    audio = Audio.create(source_file_path, new_folder)
    @audios << audio
    audio
  end

  def load_audios
    @audios = []
    audio_folders = Dir.entries("#{@folder}/audios").sort[2..-1]
    audio_folders.each do |f|
      @audios << File.open("#{@folder}/audios/#{f}/audio.yml"){|s| YAML::load(s)}
    end
  end


  def configure
    FileUtils::mkdir_p @folder
    FileUtils::mkdir_p "#{@folder}/audios"
    FileUtils::mkdir_p "#{@folder}/stats"
    FileUtils::mkdir_p "#{@folder}/temp"
    dump
    Dir.entries(@folder)
  end

  private


  def dump
    tmp = @audios
    @audios = nil
    File.open("#{@folder}/workspace.yml", "w"){|f| f.write(YAML::dump(self))}
    @audios = tmp
  end



end

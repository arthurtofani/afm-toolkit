require 'event_array'
# Each audio object represents a folder that contains:
# => The source file
# => Degradated versions of the source file
# => The onsets
#
#
#  - /audio_folder
#     |_ ./onsets
#     |_ ./versions
#     |_ ./queries
#
# /home/arthur/Documentos/USP/fingerprinting/gtzan/blues/blues.00077.au
class Audio
  def self.create(source_file_path, source_folder)
    FileUtils::mkdir_p source_folder
    FileUtils::mkdir_p "#{source_folder}/onsets"
    FileUtils::mkdir_p "#{source_folder}/versions"
    FileUtils::mkdir_p "#{source_folder}/queries"
    FileUtils::cp(source_file_path, source_folder)
    file_name = File.basename(source_file_path)
    ext_name = ".wav"
    FileUtils::mv "#{source_folder}/#{file_name}", "#{source_folder}/audio#{ext_name}" if ext_name!=".wav"
    au = Audio.new(source_folder)
    au.filename = "audio#{ext_name}"
    au.read_info
    au.dump
    audio = Audio.load(source_folder)
    audio
  end

  def self.load(folder)
    File.open("#{folder}/audio.yml"){|f| YAML::load(f) }
  end

  attr_accessor :filename, :folder, :info, :events, :onsets
  def initialize(source_audio_folder)
    @folder = source_audio_folder
    @events = {}
  end

  def events
    @events ||= EventArray.new
  end

  def create(source_audio_file)
    source_audio_file
  end

  def process_onsets(label, method_name, params)
    read_info
    #@onsets ||= {}
    nf = NoveltyFunction.instantiate_strategy(method_name, self, label)
    r = nf.process(params)
    #@onsets[label] = OnsetArray.new(label, nf.process(params), info.length)
    self.dump
    events[label]
  end

  def load_onsets
    #load_onset_yaml_files.each do ||
    #@onsets[label] = OnsetArray.
  end

  def generate_queries(time_in_seconds, amount)

  end

  def create_degradated_version(label, degradation_process_name, params)
    new_folder = "#{versions_path}/#{label}"
    Audio.create("#{@folder}/audio.wav", new_folder)
    new_audio = Audio.load(new_folder)
    new_audio.apply_degradation!(degradation_process_name, params)
    @versions = nil;
    versions
    new_audio
  end

  def apply_degradation!(degradation_name, params)
    klass = Module.const_get("Degradations::#{degradation_name.camelize}")
    degr = klass.new(self)
    degr.run(params)
  end

  def dump
    File.open("#{@folder}/audio.yml", "w"){|f| f.write(YAML::dump(self))}
  end

  def file_path
    "#{@folder}/#{@filename}"
  end

  def extension
    ext_name = File.extname(file_path)
  end

  def versions_path
    "#{@folder}/versions"
  end

  def versions
    arr = (Dir.entries(versions_path) - ['..', '.'])
    @versions ||= arr.map do |v|
      Audio.load "#{versions_path}/#{v}"
    end

  end

  def onsets_path
    "#{@folder}/onsets"
  end

  def read_info
    @info ||= AudioInformation.new(self)
  end

end

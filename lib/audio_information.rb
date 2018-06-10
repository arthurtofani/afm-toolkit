class AudioInformation
  attr_accessor :samplerate, :length
  def initialize(audio)
    RubyAudio::Sound.open(audio.file_path) do |snd|
      @samplerate = snd.info.samplerate
      @length = (snd.info.length * 1000).floor
    end
  end
end

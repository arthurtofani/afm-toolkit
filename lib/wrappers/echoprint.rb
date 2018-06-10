class Echoprint < Wrapper


  attr_accessor :onset_subbands
  def initialize(audio)
    @audio = audio
    @folder = "/home/arthur/Documentos/USP/fingerprinting/echoprint/onsets/echoprint-codegen"
  end

  def run
    str = "#{@folder}/echoprint-codegen #{@audio.file_path}"
    @onset_subbands = [ [], [], [], [], [], [], [], [] ]
    val = `#{str}`.split("\n").map{|s| s.split("-").map(&:to_i)}
    val.each do |r|
      @onset_subbands[r.first] << r.last
    end
    self
  end
end

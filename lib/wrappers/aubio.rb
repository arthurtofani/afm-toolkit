class Aubio < Wrapper
  METHODS = ["energy", "hfc", "complex", "phase", "specdiff", "kl", "mkl", "specflux"]

  def initialize(audio)
    @folder = audio.onsets_path
    @file_path = audio.file_path
  end

  def run(onset_method, params)
    raise "Invalid aubio onset method" unless METHODS.include? onset_method

    destfile = "#{@folder}/aubio_#{onset_method}.txt"
    FileUtils.rm_rf(destfile) rescue nil
    command = "aubioonset #{@file_path}"
    command += " --onset=#{onset_method} "
    command += " > #{destfile}"
    `#{command}` # executes the aubio command line
    content = File.open(destfile).read
    content.split("\n").map{|s| s.to_f}
  end

end


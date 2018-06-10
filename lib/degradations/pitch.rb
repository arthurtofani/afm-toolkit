require 'fileutils'
require 'pry'

# params:
#  {
#    semitones: 1
#  }
class Degradations::Pitch < DegradationProcess
  def run(params)
    `rubberband --pitch #{params[:semitones]} #{@audio.file_path} #{@audio.file_path}.pitch`
    FileUtils.mv(@audio.file_path, "#{@audio.file_path}.old")
    FileUtils.mv("#{@audio.file_path}.pitch", @audio.file_path)
    FileUtils.rm("#{@audio.file_path}.old")
  end
end
